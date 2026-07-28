#!/usr/bin/env python3
"""Prepend upstream GitHub release notes into an addon's CHANGELOG.md.

Intended for Renovate postUpgradeTasks. Release-note template fields are not
available there, so this script fetches notes from the GitHub Releases API using
sourceUrl / depName plus the from→to version range.

Auth (first match): GITHUB_TOKEN, GH_TOKEN, RENOVATE_TOKEN, RENOVATE_GITHUB_COM_TOKEN.
"""

from __future__ import annotations

import argparse
import json
import os
import pathlib
import re
import sys
import urllib.error
import urllib.parse
import urllib.request
from dataclasses import dataclass

_SCRIPTS_DIR = pathlib.Path(__file__).resolve().parent
if str(_SCRIPTS_DIR) not in sys.path:
    sys.path.insert(0, str(_SCRIPTS_DIR))

# Reuse the same slug + core-version rules as addon_version_sync.py
from addon_version_sync import addon_slug_from_package_file_dir, normalize_version

GITHUB_REPO_RE = re.compile(
    r"https?://(?:www\.)?github\.com/(?P<owner>[^/\s]+)/(?P<repo>[^/\s#?]+)",
    re.IGNORECASE,
)
HEADER_RE = re.compile(r"^##\s+(?P<ver>\S+)\s*$", re.MULTILINE)
BULLET_RE = re.compile(r"^\s*[-*]\s+\S")
HTML_TAG_RE = re.compile(r"<[^>]+>")
ZWSP_RE = re.compile(r"[\u200b\u200c\u200d\ufeff]|&#8203;|&ZeroWidthSpace;", re.IGNORECASE)
COMMIT_LINK_RE = re.compile(
    r"\s*[,\[]?\s*\[(?:Commit|commit)\]\([^)]+\)\.?",
    re.IGNORECASE,
)
TRAILING_SHA_RE = re.compile(r"\s+`?[0-9a-f]{7,40}`?(?:\s+`?[0-9a-f]{7,40}`?)*\s*$")
ISSUE_REF_CLEAN_RE = re.compile(r"#&#8203;(\d+)")

# Soft cap so Supervisor UI / git diffs stay usable (open-webui notes are huge).
MAX_BODY_LINES = 80
MAX_RELEASES = 20

SKIP_BULLET_PREFIXES = (
    "compare source",
    "what to download",
    "read-only demo",
    "there is a discord",
    "except for",
    "the zip and tar",
    "python packages are available",
    "[docker image]",
    "docker image]",
)

# Docker image → GitHub repo when labels / sourceUrl are missing.
KNOWN_SOURCE_REPOS: dict[str, str] = {
    "copyparty/ac": "9001/copyparty",
    "ollama/ollama": "ollama/ollama",
    "ghcr.io/open-webui/open-webui": "open-webui/open-webui",
    "ghcr.io/berriai/litellm": "BerriAI/litellm",
    "ghcr.io/raylabshq/gitea-mirror": "RayLabsHQ/gitea-mirror",
    "gravitl/netmaker-ui": "gravitl/netmaker",
    "gravitl/netmaker": "gravitl/netmaker",
    "hurlenko/aria2-ariang": "hurlenko/aria2-ariang",
    "serjs/go-socks5-proxy": "serjs/go-socks5-proxy",
    "rustfs/rustfs": "rustfs/rustfs",
}


@dataclass(frozen=True)
class ReleaseNotes:
    tag: str
    name: str
    body: str
    html_url: str
    version_key: tuple[int | str, ...]


def parse_version_key(raw: str) -> tuple[int | str, ...]:
    """Comparable key for tags like v1.20.19 / 0.11.0 / 1.0.0-beta.11."""
    s = raw.strip().strip('"').lstrip("vV")
    parts: list[int | str] = []
    for chunk in re.split(r"[.+_-]", s):
        if not chunk:
            continue
        if chunk.isdigit():
            parts.append(int(chunk))
        else:
            parts.append(chunk.lower())
    return tuple(parts) or (0,)


def version_in_range(tag: str, current: str, new: str) -> bool:
    """True if tag is strictly after current and at most new."""
    t, c, n = parse_version_key(tag), parse_version_key(current), parse_version_key(new)
    return c < t <= n


def github_token() -> str | None:
    for key in (
        "GITHUB_TOKEN",
        "GH_TOKEN",
        "RENOVATE_TOKEN",
        "RENOVATE_GITHUB_COM_TOKEN",
    ):
        val = os.environ.get(key, "").strip()
        if val:
            return val
    return None


def guess_github_repo(dep_name: str, source_url: str, dockerfile: pathlib.Path) -> str | None:
    if source_url:
        m = GITHUB_REPO_RE.search(source_url)
        if m:
            return f"{m.group('owner')}/{m.group('repo').removesuffix('.git')}"

    dep = dep_name.strip().removeprefix("docker.io/")
    if dep in KNOWN_SOURCE_REPOS:
        return KNOWN_SOURCE_REPOS[dep]

    if dockerfile.exists():
        text = dockerfile.read_text()
        for m in GITHUB_REPO_RE.finditer(text):
            owner, repo = m.group("owner"), m.group("repo").removesuffix(".git")
            # Skip pkgs/container links' path noise; prefer owner/repo form.
            if owner and repo and "/" not in repo:
                return f"{owner}/{repo}"

    for prefix in ("ghcr.io/", "quay.io/"):
        if dep.startswith(prefix):
            rest = dep[len(prefix) :]
            parts = rest.split("/")
            if len(parts) >= 2:
                return f"{parts[0]}/{parts[1]}"

    if "/" in dep and not dep.startswith("library/"):
        # Best-effort: docker hub user/image often matches GitHub org/repo.
        return dep

    return None


def github_get(url: str) -> object:
    headers = {
        "Accept": "application/vnd.github+json",
        "User-Agent": "home-assistant-apps-addon-changelog",
        "X-GitHub-Api-Version": "2022-11-28",
    }
    token = github_token()
    if token:
        headers["Authorization"] = f"Bearer {token}"
    req = urllib.request.Request(url, headers=headers)
    with urllib.request.urlopen(req, timeout=60) as resp:
        return json.load(resp)


def fetch_releases(repo: str, current: str, new: str) -> list[ReleaseNotes]:
    """Fetch releases with tags in (current, new]. Falls back to the single new tag."""
    out: list[ReleaseNotes] = []
    page = 1
    while page <= 5 and len(out) < MAX_RELEASES:
        url = (
            f"https://api.github.com/repos/{repo}/releases"
            f"?per_page=100&page={page}"
        )
        try:
            data = github_get(url)
        except urllib.error.HTTPError as e:
            print(f"GitHub releases list failed for {repo}: {e}", file=sys.stderr)
            break
        if not isinstance(data, list) or not data:
            break
        for item in data:
            if not isinstance(item, dict) or item.get("draft"):
                continue
            tag = str(item.get("tag_name") or "")
            if not tag or not version_in_range(tag, current, new):
                continue
            out.append(
                ReleaseNotes(
                    tag=tag,
                    name=str(item.get("name") or tag),
                    body=str(item.get("body") or ""),
                    html_url=str(item.get("html_url") or ""),
                    version_key=parse_version_key(tag),
                )
            )
        if len(data) < 100:
            break
        page += 1

    out.sort(key=lambda r: r.version_key)
    if out:
        return out[:MAX_RELEASES]

    # Single-tag fallback (some projects only expose the latest usefully).
    for tag in (new, f"v{normalize_version(new)}", normalize_version(new)):
        enc = urllib.parse.quote(tag, safe="")
        url = f"https://api.github.com/repos/{repo}/releases/tags/{enc}"
        try:
            item = github_get(url)
        except urllib.error.HTTPError:
            continue
        if isinstance(item, dict):
            return [
                ReleaseNotes(
                    tag=str(item.get("tag_name") or tag),
                    name=str(item.get("name") or tag),
                    body=str(item.get("body") or ""),
                    html_url=str(item.get("html_url") or ""),
                    version_key=parse_version_key(str(item.get("tag_name") or tag)),
                )
            ]
    return []


def clean_text(text: str) -> str:
    text = ZWSP_RE.sub("", text)
    text = ISSUE_REF_CLEAN_RE.sub(r"#\1", text)
    text = HTML_TAG_RE.sub("", text)
    text = text.replace("\r\n", "\n").replace("\r", "\n")
    return text.strip()


def clean_bullet(item: str) -> str:
    item = COMMIT_LINK_RE.sub("", item)
    item = TRAILING_SHA_RE.sub("", item)
    item = re.sub(r"\s*,(?:\s*,)+", ",", item)
    item = re.sub(r"\.\s*,", ".", item)
    item = re.sub(r"[ \t]{2,}", " ", item).strip(" ,;")
    return item


def should_skip_bullet(item: str) -> bool:
    lower = item.lower()
    return any(lower.startswith(p) for p in SKIP_BULLET_PREFIXES)


def release_title_bullet(rel: ReleaseNotes) -> str | None:
    name = clean_text(rel.name)
    tag = rel.tag.lstrip("vV")
    # Drop titles that are only the version.
    if not name or name.lstrip("vV") == tag or name == rel.tag:
        return None
    # "v1.20.19: SECURITY: ..." → keep the descriptive part
    for sep in (": ", " - ", " — "):
        if sep in name:
            left, right = name.split(sep, 1)
            if left.lstrip("vV") == tag or left == rel.tag:
                name = right.strip()
                break
    if not name:
        return None
    return name


def extract_bullets(body: str) -> list[str]:
    """Prefer existing markdown bullets; drop download tables and boilerplate."""
    body = clean_text(body)
    if not body:
        return []

    bullets: list[str] = []
    for line in body.splitlines():
        raw = line.rstrip()
        stripped = raw.strip()
        if not stripped:
            continue
        if stripped.startswith("#"):
            title = stripped.lstrip("#").strip()
            if title and any(k in title.lower() for k in ("attn", "security", "breaking", "warn")):
                bullets.append(title)
            continue
        if stripped.startswith("|") or stripped.startswith("---"):
            continue
        if not BULLET_RE.match(raw):
            continue
        item = clean_bullet(stripped.lstrip("-* ").strip())
        if not item or should_skip_bullet(item):
            continue
        bullets.append(item)
    return bullets


def format_section(
    addon_version: str,
    current: str,
    new: str,
    repo: str | None,
    releases: list[ReleaseNotes],
) -> str:
    lines: list[str] = [f"## {addon_version}", ""]
    compare = ""
    if repo:
        c = current if current.startswith("v") else f"v{normalize_version(current)}"
        n = new if new.startswith("v") else f"v{normalize_version(new)}"
        compare = f"https://github.com/{repo}/compare/{c}...{n}"
        lines.append(
            f"- Update upstream from `{current}` to `{new}`"
            + (f" ([compare]({compare}))" if compare else "")
        )
    else:
        lines.append(f"- Update upstream from `{current}` to `{new}`")

    body_lines = 0
    truncated = False
    for rel in releases:
        title = release_title_bullet(rel)
        if title:
            link = f" ([notes]({rel.html_url}))" if rel.html_url else ""
            lines.append(f"- {title}{link}")
            body_lines += 1
        elif rel.html_url:
            lines.append(f"- Upstream {rel.tag} ([notes]({rel.html_url}))")
            body_lines += 1

        for bullet in extract_bullets(rel.body):
            if body_lines >= MAX_BODY_LINES:
                truncated = True
                break
            lines.append(f"- {bullet}")
            body_lines += 1
        if truncated:
            break

    if truncated:
        url = releases[-1].html_url if releases else compare
        extra = f" ([full notes]({url}))" if url else ""
        lines.append(f"- … truncated upstream notes{extra}")

    lines.append("")
    return "\n".join(lines)


def changelog_has_version(text: str, version: str) -> bool:
    return any(m.group("ver") == version for m in HEADER_RE.finditer(text))


def prepend_changelog(path: pathlib.Path, section: str, version: str) -> bool:
    if path.exists():
        existing = path.read_text()
        if changelog_has_version(existing, version):
            print(f"{path}: already has ## {version}, skipping")
            return False
        if existing.lstrip().startswith("# Changelog"):
            # Insert after title line.
            parts = existing.split("\n", 1)
            rest = parts[1].lstrip("\n") if len(parts) > 1 else ""
            path.write_text(f"# Changelog\n\n{section}{rest}")
        else:
            path.write_text(f"# Changelog\n\n{section}{existing}")
    else:
        path.write_text(f"# Changelog\n\n{section}")
    return True


def cmd_update(args: argparse.Namespace) -> int:
    repo_root = pathlib.Path(__file__).resolve().parents[1]
    slug = addon_slug_from_package_file_dir(args.addon)
    addon_dir = repo_root / slug
    if not addon_dir.is_dir():
        print(f"Unknown addon directory: {slug}", file=sys.stderr)
        return 2

    current = args.from_version
    new = args.to_version
    addon_version = normalize_version(new)
    changelog = addon_dir / "CHANGELOG.md"

    repo = guess_github_repo(args.dep_name, args.source_url, addon_dir / "Dockerfile")
    releases: list[ReleaseNotes] = []
    if repo:
        print(f"{slug}: fetching release notes from {repo} ({current} → {new})")
        releases = fetch_releases(repo, current, new)
        if not releases:
            print(f"{slug}: no GitHub releases in range; writing stub entry")
    else:
        print(f"{slug}: could not resolve GitHub repo; writing stub entry", file=sys.stderr)

    section = format_section(addon_version, current, new, repo, releases)
    if prepend_changelog(changelog, section, addon_version):
        print(f"{slug}: updated {changelog.relative_to(repo_root)}")
    return 0


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "addon",
        help="Addon directory / Renovate packageFileDir (e.g. copyparty)",
    )
    parser.add_argument("--from", dest="from_version", required=True, help="Previous image tag")
    parser.add_argument("--to", dest="to_version", required=True, help="New image tag")
    parser.add_argument("--source-url", default="", help="Renovate sourceUrl if available")
    parser.add_argument("--dep-name", default="", help="Renovate depName (docker image)")
    args = parser.parse_args()
    return cmd_update(args)


if __name__ == "__main__":
    sys.exit(main())
