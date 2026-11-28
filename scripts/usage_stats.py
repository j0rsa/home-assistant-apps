#!/usr/bin/env python3
"""Collect GHCR download counts for every app and render a usage chart.

GHCR has no API for download counts, so the "Total downloads" number is read
from each package's public GitHub page. One snapshot per day is appended to a
JSON history file; the SVG shows downloads over the last 7/30 days (deltas
between snapshots), the all-time total and a daily sparkline per app.

Downloads count image pulls: installs *and* updates. Apps that release often
get more pulls per user, so compare trends rather than absolute numbers.

Stdlib only, so it runs on a bare GitHub runner.
"""

from __future__ import annotations

import argparse
import datetime as dt
import html
import json
import os
import re
import sys
import time
import urllib.error
import urllib.request
from pathlib import Path

DOWNLOADS_RE = re.compile(r'Total downloads</span>\s*<h3 title="(\d+)"')
IMAGE_RE = re.compile(r'^image:\s*"?([^"\s]+)"?\s*$', re.M)
NAME_RE = re.compile(r'^name:\s*"?(.+?)"?\s*$', re.M)
ARCH_BLOCK_RE = re.compile(r"^arch:\s*\n((?:\s+-\s*\S+\s*\n)+)", re.M)
SPARK_DAYS = 60
# Explicit colors instead of CSS variables: not every SVG renderer supports them.
ARCH_ORDER = ["amd64", "aarch64", "armv7", "armhf", "i386"]
LIGHT = {"bg": "#ffffff", "fg": "#1f2328", "muted": "#656d76", "grid": "#d0d7de", "dead": "#cf222e",
         "arch": ["#2f81f7", "#d4760a", "#8250df", "#1a7f37", "#bf3989"]}
DARK = {"bg": "#0d1117", "fg": "#e6edf3", "muted": "#8d96a0", "grid": "#30363d", "dead": "#f85149",
        "arch": ["#4493f8", "#f0883e", "#a371f7", "#3fb950", "#db61a2"]}


def palette_css(p: dict) -> str:
    return (
        f".bg{{fill:{p['bg']}}}.fg{{fill:{p['fg']}}}.muted{{fill:{p['muted']}}}.dead{{fill:{p['dead']}}}"
        f".grid{{stroke:{p['grid']}}}"
        + "".join(f".a{i}{{fill:{c}}}.s{i}{{stroke:{c}}}" for i, c in enumerate(p["arch"]))
    )


def discover_apps(root: Path) -> list[dict]:
    apps = []
    for cfg in sorted(root.glob("*/config.yaml")):
        text = cfg.read_text()
        image = IMAGE_RE.search(text)
        if not image:
            continue
        name = NAME_RE.search(text)
        arch_block = ARCH_BLOCK_RE.search(text)
        archs = re.findall(r"-\s*(\S+)", arch_block.group(1)) if arch_block else []
        apps.append(
            {
                "slug": cfg.parent.name,
                "name": name.group(1) if name else cfg.parent.name,
                "image": image.group(1),
                "archs": archs,
            }
        )
    return apps


def fetch_downloads(repo: str, package: str) -> int | None:
    """Total downloads for a package, or None if it isn't published."""
    url = f"https://github.com/{repo}/pkgs/container/{package}"
    req = urllib.request.Request(url, headers={"User-Agent": "ha-apps-usage-stats"})
    for attempt in range(3):
        try:
            with urllib.request.urlopen(req, timeout=30) as resp:
                page = resp.read().decode("utf-8", "replace")
            break
        except urllib.error.HTTPError as err:
            if err.code == 404:
                return None
            if attempt == 2:
                raise
        except urllib.error.URLError:
            if attempt == 2:
                raise
        time.sleep(5 * (attempt + 1))
    match = DOWNLOADS_RE.search(page)
    if not match:
        raise RuntimeError(f"'Total downloads' not found on {url}; GitHub markup changed?")
    return int(match.group(1))


def collect(apps: list[dict], repo: str) -> dict[str, dict[str, int]]:
    snapshot: dict[str, dict[str, int]] = {}
    for app in apps:
        per_arch = {}
        for arch in app["archs"]:
            package = app["image"].split("/")[-1].replace("{arch}", arch)
            count = fetch_downloads(repo, package)
            print(f"{app['slug']:<24} {arch:<8} {count if count is not None else 'not published'}")
            if count is not None:
                per_arch[arch] = count
            time.sleep(1)
        snapshot[app["slug"]] = per_arch
    return snapshot


def total(snapshot: dict, slug: str, arch: str | None = None) -> int | None:
    per_arch = snapshot.get(slug) or {}
    if arch is not None:
        return per_arch.get(arch)
    return sum(per_arch.values()) if per_arch else None


def window_delta(
    history: dict, slug: str, today: str, days: int, arch: str | None = None
) -> tuple[int | None, bool]:
    """Downloads within the last `days`; flag is True when history is shorter."""
    dates = sorted(history)
    cutoff = (dt.date.fromisoformat(today) - dt.timedelta(days=days)).isoformat()
    older = [d for d in dates if d <= cutoff]
    partial = not older
    base_date = older[-1] if older else dates[0]
    now = total(history[today], slug, arch)
    base = total(history[base_date], slug, arch)
    if now is None or base_date == today:
        return None, partial
    return now - (base or 0), partial


def daily_series(history: dict, slug: str, arch: str | None = None) -> list[int]:
    dates = sorted(history)[-(SPARK_DAYS + 1):]
    totals = [total(history[d], slug, arch) for d in dates]
    series = []
    for prev, cur in zip(totals, totals[1:]):
        series.append(max(cur - prev, 0) if prev is not None and cur is not None else 0)
    return series


def fmt(value: int | None, partial: bool = False) -> str:
    if value is None:
        return "—"
    return f"{value:,}{'*' if partial else ''}"


def ordered_archs(apps: list[dict]) -> list[str]:
    seen = {a for app in apps for a in app["archs"]}
    known = [a for a in ARCH_ORDER if a in seen]
    return known + sorted(seen - set(known))


def render_svg(apps: list[dict], history: dict, today: str) -> str:
    archs = ordered_archs(apps)
    rows = []
    for app in apps:
        per = {}
        for arch in archs:
            if arch not in app["archs"]:
                continue
            d30, p30 = window_delta(history, app["slug"], today, 30, arch)
            d7, p7 = window_delta(history, app["slug"], today, 7, arch)
            per[arch] = {
                "d30": d30, "p30": p30, "d7": d7, "p7": p7,
                "total": total(history[today], app["slug"], arch),
                "spark": daily_series(history, app["slug"], arch),
            }
        d30_all = sum(v["d30"] or 0 for v in per.values())
        rows.append({
            "name": app["name"],
            "per": per,
            "d30": d30_all,
            "full30": any(v["d30"] is not None and not v["p30"] for v in per.values()),
            "total": sum(v["total"] or 0 for v in per.values()),
        })
    rows.sort(key=lambda r: (r["d30"], r["total"]), reverse=True)

    row_h, top, left = 26, 84, 16
    name_w, bar_w, num_w, spark_w, gap = 180, 150, 52, 120, 14
    x_bar = left + name_w
    x_groups = x_bar + bar_w + gap
    group_w = num_w * 3
    x_spark = x_groups + group_w * len(archs) + gap * len(archs)
    width = x_spark + spark_w + left
    height = top + row_h * len(rows) + 40
    max_d30 = max([r["d30"] for r in rows] + [1])
    has_partial = any(v["p30"] or v["p7"] for r in rows for v in r["per"].values())

    def gx(i: int) -> int:
        return x_groups + i * (group_w + gap)

    out = [
        f'<svg xmlns="http://www.w3.org/2000/svg" width="{width}" height="{height}" '
        f'viewBox="0 0 {width} {height}" font-family="-apple-system,Segoe UI,Helvetica,Arial,sans-serif" font-size="13">',
        "<style>",
        palette_css(LIGHT),
        "@media (prefers-color-scheme: dark){" + palette_css(DARK) + "}",
        ".spark{fill:none;stroke-width:1.5}",
        ".num{text-anchor:end;font-variant-numeric:tabular-nums}.h{font-weight:600}.mid{text-anchor:middle}",
        "</style>",
        f'<rect class="bg" width="{width}" height="{height}" rx="6"/>',
        f'<text class="fg h" x="{left}" y="26" font-size="15">App downloads (GHCR image pulls)</text>',
        f'<text class="muted num" x="{width - left}" y="26">updated {today}</text>',
        f'<text class="muted" x="{left}" y="{top - 10}">App</text>',
        f'<text class="muted" x="{x_bar}" y="{top - 10}">last 30 days</text>',
        f'<text class="muted" x="{x_spark}" y="{top - 10}">daily, {SPARK_DAYS}d</text>',
    ]
    for i, arch in enumerate(archs):
        x = gx(i)
        out.append(f'<rect class="a{i}" x="{x + group_w / 2 - 34}" y="{top - 36}" width="10" height="10" rx="2"/>')
        out.append(f'<text class="fg h" x="{x + group_w / 2 - 20}" y="{top - 27}">{html.escape(arch)}</text>')
        out.append(f'<line class="grid" x1="{x + 4}" x2="{x + group_w}" y1="{top - 22}" y2="{top - 22}"/>')
        for j, label in enumerate(("30d", "7d", "total")):
            out.append(f'<text class="muted num" x="{x + (j + 1) * num_w}" y="{top - 10}">{label}</text>')
    out.append(f'<line class="grid" x1="{left}" x2="{width - left}" y1="{top - 4}" y2="{top - 4}"/>')

    for i, r in enumerate(rows):
        y = top + i * row_h
        cy = y + row_h / 2 + 4
        dead = r["d30"] == 0 and r["full30"]
        out.append(f'<text class="{"dead" if dead else "fg"}" x="{left}" y="{cy}">{html.escape(r["name"])}</text>')
        x = float(x_bar)
        for k, arch in enumerate(archs):
            v = r["per"].get(arch)
            w = ((v or {}).get("d30") or 0) / max_d30 * bar_w
            if w:
                out.append(f'<rect class="a{k}" x="{x:.1f}" y="{y + 7}" width="{max(w, 2):.1f}" height="{row_h - 14}"/>')
                x += max(w, 2)
        for k, arch in enumerate(archs):
            v = r["per"].get(arch)
            gxk = gx(k)
            if v is None:
                out.append(f'<text class="muted mid" x="{gxk + group_w / 2 + 8}" y="{cy}" font-size="11">not built</text>')
                continue
            zero = v["d30"] == 0 and not v["p30"]
            cells = ((fmt(v["d30"], v["p30"]), "dead" if zero else "fg"),
                     (fmt(v["d7"], v["p7"]), "fg"),
                     (fmt(v["total"]), "muted"))
            for j, (text, cls) in enumerate(cells):
                out.append(f'<text class="{cls} num" x="{gxk + (j + 1) * num_w}" y="{cy}">{text}</text>')
        sparks = [(k, r["per"][a]["spark"]) for k, a in enumerate(archs) if a in r["per"]]
        if sparks and len(sparks[0][1]) >= 2:
            peak = max(max(s) for _, s in sparks) or 1
            for k, spark in sparks:
                step = spark_w / (len(spark) - 1)
                pts = " ".join(
                    f"{x_spark + j * step:.1f},{y + row_h - 6 - v / peak * (row_h - 12):.1f}" for j, v in enumerate(spark)
                )
                out.append(f'<polyline class="spark s{k}" points="{pts}"/>')
        else:
            out.append(f'<text class="muted" x="{x_spark}" y="{cy}">collecting…</text>')
        out.append(f'<line class="grid" x1="{left}" x2="{width - left}" y1="{y + row_h}" y2="{y + row_h}" stroke-opacity="0.5"/>')

    note = "red = no downloads in 30 days (app name: on every arch)"
    if has_partial:
        note += f" · * = less history than the window (since {sorted(history)[0]})"
    out.append(f'<text class="muted" x="{left}" y="{height - 14}" font-size="11">{note}</text>')
    out.append("</svg>")
    return "\n".join(out) + "\n"


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--root", type=Path, default=Path(__file__).resolve().parent.parent)
    parser.add_argument("--repo", default=os.environ.get("GITHUB_REPOSITORY", "j0rsa/home-assistant-apps"))
    parser.add_argument("--data", type=Path, default=Path("stats/downloads.json"))
    parser.add_argument("--svg", type=Path, default=Path("stats/downloads.svg"))
    parser.add_argument("--dry-run", action="store_true", help="fetch and print, write nothing")
    args = parser.parse_args()

    apps = discover_apps(args.root)
    if not apps:
        print("no apps found", file=sys.stderr)
        return 1
    today = dt.datetime.now(dt.timezone.utc).date().isoformat()
    history = json.loads(args.data.read_text()) if args.data.exists() else {}
    history[today] = collect(apps, args.repo)

    svg = render_svg(apps, history, today)
    if args.dry_run:
        print(f"dry run: {len(apps)} apps, {len(history)} snapshots, svg {len(svg)} bytes")
        return 0
    args.data.parent.mkdir(parents=True, exist_ok=True)
    args.data.write_text(json.dumps(dict(sorted(history.items())), indent=1, sort_keys=True) + "\n")
    args.svg.parent.mkdir(parents=True, exist_ok=True)
    args.svg.write_text(svg)
    print(f"wrote {args.data} and {args.svg}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
