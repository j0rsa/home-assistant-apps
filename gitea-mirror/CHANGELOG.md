# Changelog

## 3.27.2

- Update upstream from `v3.27.0` to `v3.27.2` ([compare](https://github.com/RayLabsHQ/gitea-mirror/compare/v3.27.0...v3.27.2))
- Upstream v3.27.1 ([notes](https://github.com/RayLabsHQ/gitea-mirror/releases/tag/v3.27.1))
- Mirror Options is now reachable on mobile** (#365, reported by @MMMMMoris in #361). The per-repository mirror options added in v3.27.0 could only be opened from the desktop table. Mobile repository cards now have a three-dot menu with the same dialog, and show the Custom badge when a repository overrides the defaults. The Organizations page had the reverse gap, with the menu item present on mobile but missing from the desktop dropdown, which is also fixed.
- Upstream v3.27.2 ([notes](https://github.com/RayLabsHQ/gitea-mirror/releases/tag/v3.27.2))
- SSO sign-in with internal identity providers works again** (#366). Since v3.21.0, the auth library's SSRF hardening rejected SSO sign-ins whose IdP hostname resolves to a private address (common homelab split-DNS setups) unless the origin was manually added to `BETTER_AUTH_TRUSTED_ORIGINS`. Registered providers' issuer and endpoint origins are now trusted automatically. Because sessions last 30 days, this breakage could surface weeks after updating, whenever you next had to sign in.
- SSO sign-in errors are now shown on the login page** instead of the button silently flipping back from "Redirecting..." with nothing in the logs.
- `CLEANUP_DELETE_FROM_GITEA` is now honored** (#366). It was documented as gating Gitea-side deletion but was never read, so orphaned-repo cleanup always archived or deleted repos on the Gitea/Forgejo side. With the flag `false` (the default), cleanup now only updates gitea-mirror's own database and leaves your Gitea/Forgejo copies untouched.
- Behavior change**: if you relied on the old unconditional Gitea-side archive/delete, set `CLEANUP_DELETE_FROM_GITEA=true` to keep it.
## 3.27.0

- Update upstream from `v3.26.2` to `v3.27.0` ([compare](https://github.com/RayLabsHQ/gitea-mirror/compare/v3.26.2...v3.27.0))
- Upstream v3.27.0 ([notes](https://github.com/RayLabsHQ/gitea-mirror/releases/tag/v3.27.0))
- Mirror options can now be set per repository and per organization** (#362, requested in #361 by @MMMMMoris). Options that were global only, Git LFS, issues, pull requests, releases, wiki, labels and milestones, can now be overridden on individual repos and orgs.
- Options that can't take effect are now disabled and explain why**, instead of silently doing nothing. Starred repos with "starred code only" turned on show their metadata options greyed out with the reason, and the labels option explains that issues mirroring already syncs labels.
- Repository and organization updates no longer wipe the destination override.** Both endpoints previously rewrote that field on every request, so an update touching anything else would clear it. They now only change the fields you actually send.
- Scheduled syncs now honor mirror settings.** The sync path read its own copy of the options, so changes applied on the first mirror and were ignored on every sync after that.
## 3.26.2

- Update upstream from `v3.26.0` to `v3.26.2` ([compare](https://github.com/RayLabsHQ/gitea-mirror/compare/v3.26.0...v3.26.2))
- Upstream v3.26.1 ([notes](https://github.com/RayLabsHQ/gitea-mirror/releases/tag/v3.26.1))
- Long repository names no longer wrap in the repositories table.** Names and owner/repo paths that used to break onto two lines now stay on a single line, truncated with an ellipsis. Hovering over the text scrolls it sideways so you can read the full name, and it slides back when you move the mouse away.
- Upstream v3.26.2 ([notes](https://github.com/RayLabsHQ/gitea-mirror/releases/tag/v3.26.2))
- Smoother hover scrolling for long repository names.** The marquee added in v3.26.1 was choppy because it animated a layout property. It now uses a GPU-composited transform, so the scroll is smooth. The hover target is also bigger: hovering anywhere over the repository cell scrolls both the name and the owner/repo path together.
## 3.26.0-1

- Rebuild images after codenotary/`app_config` migration so CI publishes updated manifests

## 3.26.0

- Update upstream from `v3.25.0` to `v3.26.0` ([compare](https://github.com/RayLabsHQ/gitea-mirror/compare/v3.25.0...v3.26.0))
- Upstream v3.26.0 ([notes](https://github.com/RayLabsHQ/gitea-mirror/releases/tag/v3.26.0))
- GitHub API calls now reuse ETags across syncs** (#356, thanks @joshfree). Every GET replays the previously seen `ETag` as `If-None-Match`, so when nothing changed GitHub answers `304 Not Modified` and the cached body is used instead of a full download. Authorized 304s do not count against the token's primary rate limit, so large mirror sets and short sync intervals are much less likely to hit throttling. The cache is in-memory and per-user, keyed by the fully expanded request URL, bounded by both entry count and a 64MB byte budget, and clients created with only a token get a hashed token scope so users never share cache entries. No configuration needed and no schema changes; sync results are identical.
## 3.25.0-1

- Remove deprecated `codenotary` field from config and build metadata
- Replace legacy `addon_config` map type with `app_config`

## 3.25.0

- Update upstream from `v3.22.0` to `v3.25.0` ([compare](https://github.com/RayLabsHQ/gitea-mirror/compare/v3.22.0...v3.25.0))
- Upstream v3.23.0 ([notes](https://github.com/RayLabsHQ/gitea-mirror/releases/tag/v3.23.0))
- Generic webhook notification provider** (#352). Webhook joins ntfy, Apprise and Gotify as a supported notification channel. Point it at any URL and Gitea Mirror sends a JSON POST with title, message, type and timestamp whenever a mirror job finishes or fails. Set an optional signing secret and every request also carries an X-Webhook-Signature header (HMAC-SHA256 of the body, `sha256=`) so your receiver can verify it came from your instance. The secret is encrypted at rest like the other provider tokens. Configurable from Settings → Notifications, no database migration needed. Works with n8n, Home Assistant, or anything else that accepts a plain webhook. Thanks @jostrasser for the suggestion.
- Upstream v3.24.0 ([notes](https://github.com/RayLabsHQ/gitea-mirror/releases/tag/v3.24.0))
- Full UI redesign of the dashboard and configuration screens** (#353). A new design language across the app: cards with icon headers and status footers, header-level enable switches, toggle switches everywhere checkboxes used to be, selection tiles with icon chips for organization strategy, destructive update protection and orphaned repo handling, segmented controls, one-line option descriptions with details behind info tooltips, and an indigo accent for active states. The Connections tab is restructured with equal-height connection cards, a token creation guide, and every mirror option surfaced including starred content and org limiting. The time format menu now shows your locale and live format examples with a live clock in the header, and the theme switcher moved to the sidebar as a compact icon control. All settings behavior, autosave and APIs are unchanged, and light mode is fully supported.
- The Automation schedule no longer displays a stored legacy "UTC" timezone as if you chose it; it falls back to your browser timezone.
- The "system" theme preference now persists across reloads and follows OS changes live.
- The configuration tab bar wraps onto two rows on narrow screens instead of overflowing.
- Upstream v3.25.0 ([notes](https://github.com/RayLabsHQ/gitea-mirror/releases/tag/v3.25.0))
- Documentation moved to the website** (#354). Full docs now live at [gitea-mirror.raylabs.io/docs](https://gitea-mirror.raylabs.io/docs/) with sidebar navigation, per-page contents, mobile support and dark mode. Ten pages written fresh from the current code, including first-time coverage of notifications (all four providers with webhook signature verification), header authentication, force-push protection, and Helm and Nix deployment. The in-app docs pages are retired: old bookmarks redirect to the website, and the markdown files under `docs/` remain as the versioned offline reference. This also corrects every inaccuracy found in the docs audit, including the wrong container image name and the outdated `JWT_SECRET` guidance (use `BETTER_AUTH_SECRET`).
- `DATABASE_URL` now actually works.** The variable was documented but the SQLite path was hardcoded to `data/gitea-mirror.db`. It now accepts `sqlite://`, `file:`, or a plain path, so you can relocate the database without symlinks. Defaults are unchanged.
- The Helm chart's `appVersion` was 17 releases behind, which silently pinned old images when `image.tag` was left empty. Bumped to 3.24.0 in the chart, and the deployment docs recommend setting `image.tag` explicitly.
- `docs/NOTIFICATIONS.md` no longer claims the "new repo discovered" notification works; it is designed but not yet implemented.
## 3.22.0

- Update upstream from `v3.21.0` to `v3.22.0` ([compare](https://github.com/RayLabsHQ/gitea-mirror/compare/v3.21.0...v3.22.0))
- Upstream v3.22.0 ([notes](https://github.com/RayLabsHQ/gitea-mirror/releases/tag/v3.22.0))
- Gotify notification provider** (#337). Gotify joins ntfy and Apprise as a supported notification channel. Point it at your Gotify server URL, paste an application token (encrypted at rest like the other providers), and pick a default priority — errors are always sent at priority 8 so failures cut through. Configurable from Settings → Notifications, no database migration needed. Thanks @yunyuyuan for the contribution.
- Nix flake build repaired** (#350). `bun.nix` (the Nix translation of `bun.lock` used by the flake build) had drifted since the dependency updates in v3.21.0: 254 packages were missing and 195 entries were stale, so `nix build` was broken and Nix installs weren't getting the security updates. The file is regenerated and now matches `bun.lock` exactly, entry for entry. Thanks @Cyberboss for catching it and for the fix.
- The Nix workflow now **fails when `bun.nix` is out of date** instead of silently regenerating it on the fly, so this class of drift can't land on `main` again. If you bump dependencies, run `nix run github:nix-community/bun2nix -- -o bun.nix` (requires Nix) and commit the result.
