#!/usr/bin/env python3
"""Align Home Assistant addon config.yaml version with upstream image tag from Dockerfile.

Normalization matches .github/workflows/version-sync-check.yml:
  - strip optional v/V prefix
  - take the part before the first '-' (drops prerelease / suffix segments)

Examples:
  v0.2.0 -> 0.2.0
  v0.2.1-dev-awesome -> 0.2.1
"""

from __future__ import annotations

import argparse
import pathlib
import re
import subprocess
import sys

VERSION_PATTERNS = [
    re.compile(r"^ARG\s+UPSTREAM_IMAGE=.*:v?(?P<version>[0-9][A-Za-z0-9._-]*)", re.MULTILINE),
    re.compile(r"^FROM\s+[^\s:]+:v?(?P<version>[0-9][A-Za-z0-9._-]*)", re.MULTILINE),
    re.compile(
        r'^ARG\s+[A-Z0-9_]*VERSION\s*=\s*"?v?(?P<version>[0-9][A-Za-z0-9._-]*)"?',
        re.MULTILINE,
    ),
]
CONFIG_VERSION_LINE = re.compile(r'^version:\s*"?(?P<version>[^"\s]+)"?', re.MULTILINE)


def addon_slug_from_package_file_dir(raw: str) -> str:
    """Renovate `packageFileDir` may be `ollama`, `./ollama`, or nested `foo/bar`."""
    s = raw.strip().replace("\\", "/").removesuffix("/").removeprefix("./")
    if "/" in s:
        return s.split("/")[-1]
    return s


def normalize_version(raw: str) -> str:
    """Core release for HA addon version: strip v prefix and first hyphen suffix."""
    s = raw.strip().strip('"').lstrip("vV")
    if "-" in s:
        s = s.split("-", 1)[0]
    return s


def extract_dockerfile_version(text: str) -> str | None:
    for pat in VERSION_PATTERNS:
        m = pat.search(text)
        if m:
            return m.group("version")
    return None


def replace_config_version_line(content: str, new_core: str) -> str:
    """Replace the first version: line with unquoted semver core."""

    def repl(_m: re.Match[str]) -> str:
        return f"version: {new_core}"

    updated, n = CONFIG_VERSION_LINE.subn(repl, content, count=1)
    if n != 1:
        raise ValueError("expected exactly one version: line in config")
    return updated


def iter_addon_dirs(root: pathlib.Path) -> list[pathlib.Path]:
    skip = {".git", "docs", "blueprints", ".github"}
    out: list[pathlib.Path] = []
    for p in sorted(root.iterdir()):
        if not p.is_dir() or p.name.startswith("."):
            continue
        if p.name in skip:
            continue
        if (p / "Dockerfile").exists() and (p / "config.yaml").exists():
            out.append(p)
    return out


def cmd_sync(repo_root: pathlib.Path, addons: list[str] | None) -> int:
    dirs = iter_addon_dirs(repo_root)
    if addons:
        wanted = {addon_slug_from_package_file_dir(a) for a in addons}
        dirs = [d for d in dirs if d.name in wanted]
        missing = wanted - {d.name for d in dirs}
        if missing:
            print(f"Unknown or incomplete addons (need Dockerfile + config.yaml): {sorted(missing)}", file=sys.stderr)
            return 2

    changed: list[str] = []
    for addon_dir in dirs:
        dockerfile = addon_dir / "Dockerfile"
        config = addon_dir / "config.yaml"
        text_d = dockerfile.read_text()
        upstream = extract_dockerfile_version(text_d)
        if not upstream:
            continue
        norm_upstream = normalize_version(upstream)
        cfg_text = config.read_text()
        m = CONFIG_VERSION_LINE.search(cfg_text)
        if not m:
            print(f"{addon_dir.name}: could not parse version from config.yaml", file=sys.stderr)
            return 1
        current_core = normalize_version(m.group("version"))
        if current_core == norm_upstream:
            continue
        config.write_text(replace_config_version_line(cfg_text, norm_upstream))
        changed.append(addon_dir.name)

    if changed:
        print("Updated config.yaml for:", ", ".join(changed))
    else:
        print("No config.yaml version changes needed.")
    return 0


def cmd_check(repo_root: pathlib.Path, base_sha: str) -> int:
    diff = subprocess.check_output(
        ["git", "diff", "--name-only", f"{base_sha}...HEAD"],
        cwd=repo_root,
        text=True,
    ).splitlines()

    addon_dirs = sorted({p.split("/", 1)[0] for p in diff if p.endswith("/Dockerfile")})
    failures: list[str] = []
    checked: list[tuple[str, str, str]] = []

    for addon in addon_dirs:
        addon_path = repo_root / addon
        dockerfile = addon_path / "Dockerfile"
        config = addon_path / "config.yaml"
        if not dockerfile.exists() or not config.exists():
            continue

        before = subprocess.run(
            ["git", "show", f"{base_sha}:{addon}/Dockerfile"],
            cwd=repo_root,
            text=True,
            capture_output=True,
            check=False,
        ).stdout
        after_docker = dockerfile.read_text()

        before_version = extract_dockerfile_version(before) if before else None
        after_version = extract_dockerfile_version(after_docker)

        if not after_version or before_version == after_version:
            continue

        config_text = config.read_text()
        m = CONFIG_VERSION_LINE.search(config_text)
        if not m:
            failures.append(f"{addon}: could not parse version from config.yaml")
            continue

        addon_version = m.group("version")
        checked.append((addon, after_version, addon_version))
        norm_upstream = normalize_version(after_version)
        norm_config = normalize_version(addon_version)
        if norm_config != norm_upstream:
            failures.append(
                f"{addon}: Docker/upstream tag is {after_version} (core {norm_upstream}), "
                f"but config.yaml version is {addon_version} (core {norm_config}); cores must match"
            )

    if checked:
        print("Checked addons:")
        for addon, upstream, addon_version in checked:
            print(
                f" - {addon}: upstream={upstream} (core {normalize_version(upstream)}), "
                f"config={addon_version} (core {normalize_version(addon_version)})"
            )
    else:
        print("No addon Docker/upstream version changes detected.")

    if failures:
        print("\nFailures:", file=sys.stderr)
        for failure in failures:
            print(f" - {failure}", file=sys.stderr)
        return 1
    return 0


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    sub = parser.add_subparsers(dest="command", required=True)

    p_check = sub.add_parser("check", help="Verify config matches Dockerfile when Dockerfile changed (CI)")
    p_check.add_argument("--base-sha", required=True, help="Merge base commit")

    p_sync = sub.add_parser("sync", help="Rewrite config.yaml version from Dockerfile upstream tag")
    p_sync.add_argument(
        "addons",
        nargs="*",
        help="Restrict to these addon directory names (default: all addons with Dockerfile + config.yaml)",
    )

    args = parser.parse_args()
    repo_root = pathlib.Path(__file__).resolve().parents[1]

    if args.command == "check":
        return cmd_check(repo_root, args.base_sha)
    if args.command == "sync":
        return cmd_sync(repo_root, args.addons if args.addons else None)

    return 1


if __name__ == "__main__":
    sys.exit(main())
