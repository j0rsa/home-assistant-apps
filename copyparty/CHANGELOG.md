# Changelog

## 1.20.20-1

- Remove deprecated `codenotary` field from config and build metadata
- Replace legacy `addon_config` / `all_addon_configs` map types with `app_config` / `all_app_configs`
- Rename Copyparty URL paths to `/app-config` and `/app-configs` (container path `/app_configs`)

## 1.20.20

- Update upstream from `1.20.19` to `1.20.20` ([compare](https://github.com/9001/copyparty/compare/v1.20.19...v1.20.20))
- more wopi ([notes](https://github.com/9001/copyparty/releases/tag/v1.20.20))
- [v1.20.19 (2026-07-27)](https://github.com/9001/copyparty/releases/tag/v1.20.19) fixed an FTP-server vuln (upload outside defined volumes)
- [v1.20.17 (2026-07-06)](https://github.com/9001/copyparty/releases/tag/v1.20.17) fixed a vuln when a volume has both filekeys and dirkeys enabled
- [v1.20.17 (2026-07-06)](https://github.com/9001/copyparty/releases/tag/v1.20.17) introduced csp nonces, possibly breaking some javascript-based plugins
- #1574 #1585 wopi: probably support onlyoffice as wopi-client (thx @kamaeff!)
- #1580 wopi: `--wopi-urls` to choose a different wopi-client url based on current domain (thx @kamaeff!)
- #634 #1033 #1390 correct size of volumes in directory listings (thx @vmattphillips!)
- #1577 thumbnails for krita `.kra` and openraster `.ora` images (thx @Wuerfel21!)
- hotkey F4 to reload/refresh the directory listing
- #1581 ctrl-a in search results
- show an explanation in the web-UI if javascript is broken due to misconfigured hosting-stack (the ["csp nonce"](https://github.com/9001/copyparty/#csp-nonce) stuff)
- improve upload performance when running behind a buggy or bufferbloating reverseproxy
- #1582 Nixos: fix version checker (thx @sylfn!)

## 1.20.19-1

- Add optional `readonly` account with read-only access to all volumes when `readonly_password` is set

## 1.20.18-1

- Expose `/backup` in Copyparty to match `backup:rw` in `config.yaml`
- Align README, docs, and startup logs with all mapped folders
- Remove `username` option; login is always `admin`

## 1.20.18

- Initial release of Copyparty file server
- Map and expose `/addon-config`, `/addon-configs`, `/homeassistant`, `/share`, `/media`, and `/ssl` (read-only)
- Options for admin account, anonymous access mode, indexing, and server name
