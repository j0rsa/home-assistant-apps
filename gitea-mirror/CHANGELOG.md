# Changelog

## 3.22.0

- Update upstream from `v3.21.0` to `v3.22.0` ([compare](https://github.com/RayLabsHQ/gitea-mirror/compare/v3.21.0...v3.22.0))
- Upstream v3.22.0 ([notes](https://github.com/RayLabsHQ/gitea-mirror/releases/tag/v3.22.0))
- Gotify notification provider** (#337). Gotify joins ntfy and Apprise as a supported notification channel. Point it at your Gotify server URL, paste an application token (encrypted at rest like the other providers), and pick a default priority — errors are always sent at priority 8 so failures cut through. Configurable from Settings → Notifications, no database migration needed. Thanks @yunyuyuan for the contribution.
- Nix flake build repaired** (#350). `bun.nix` (the Nix translation of `bun.lock` used by the flake build) had drifted since the dependency updates in v3.21.0: 254 packages were missing and 195 entries were stale, so `nix build` was broken and Nix installs weren't getting the security updates. The file is regenerated and now matches `bun.lock` exactly, entry for entry. Thanks @Cyberboss for catching it and for the fix.
- The Nix workflow now **fails when `bun.nix` is out of date** instead of silently regenerating it on the fly, so this class of drift can't land on `main` again. If you bump dependencies, run `nix run github:nix-community/bun2nix -- -o bun.nix` (requires Nix) and commit the result.
