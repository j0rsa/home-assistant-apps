# Changelog

## 1.20.21

- Update upstream from `1.20.20` to `1.20.21` ([compare](https://github.com/9001/copyparty/compare/v1.20.20...v1.20.21))
- thumbex ([notes](https://github.com/9001/copyparty/releases/tag/v1.20.21))
- [v1.20.19 (2026-07-27)](https://github.com/9001/copyparty/releases/tag/v1.20.19) fixed an FTP-server vuln (upload outside defined volumes)
- [v1.20.17 (2026-07-06)](https://github.com/9001/copyparty/releases/tag/v1.20.17) fixed a vuln when a volume has both filekeys and dirkeys enabled
- [v1.20.17 (2026-07-06)](https://github.com/9001/copyparty/releases/tag/v1.20.17) introduced csp nonces, possibly breaking some javascript-based plugins
- #1602 custom thumbnail extractors; [docs/example](https://github.com/9001/copyparty/tree/hovudstraum/bin/thumbs) (thx @kamaeff!)
- #1604 [u2c](https://github.com/9001/copyparty/tree/hovudstraum/bin#u2cpy): password can be provided in env-var `U2C_PW` (thx @shermanhlc!)
- wopi: option [--wopi-accs](https://copyparty.eu/cli/#g-wopi-accs) to limit who's able to use the feature
- also fixes wopi on servers where user does not have read/write-access to root volume
- also restricts the token to just that one file; good if the wopi-client is some cloud thing that shouldn't be trusted
- #1591 wopi: use persistent file-ID which is necessary for real-time collab (thx @kamaeff!)
- #1605 the lightbox can show svg images now
- up2k: client could waste a little bandwidth while recovering from a network glitch
- if `PRTY_CONFIG` is set to a config-file that is also autodetected, then explain the misconfiguration instead of crashing like before
- wopi: fix session-timeout hint to clients (thx @kamaeff!)
- js: fix chance of duplicate prologue on very first page visit
- js: fix panic on image dragdrop out of the browser window
- up2k: client now detects when server or reverseproxy is incorrectly configured with an impractically small request-body-size-limit, crashing the website with [an explanation](https://github.com/9001/copyparty/#u2sz) how to fix it
- also allows setting the chunksize all the way down to 1 megabyte when absolutely necessary (bad idea, slow)
- new option [--allow-svg-js](https://copyparty.eu/cli/#g-allow-svg-js) if you really want that
- shares: harden single-file shares some more
- just removing footguns (motivated by a bug-report that was a false-positive)
- copyparty.exe: upgrade to python 3.14.7 from 3.13.14
- larger and slightly faster (compensated for the size bloat by making the text-image-generator more shitty)
- the [thumbex example](https://github.com/9001/copyparty/blob/hovudstraum/bin/thumbs/randomcolor.py) is also a cool example how relevant the "pseudo" in PRNG can be; with `random.randrange` instead of `os.urandom`, [first run](https://a.ocv.me/pub/g/2026/08/Screenshot_2026-08-15_19-56-35.png?cache) followed by restarting copyparty and [another run](https://a.ocv.me/pub/g/2026/08/Screenshot_2026-08-15_19-56-38.png?cache)...heh
## 1.20.20-2

- Rebuild images after codenotary/`app_config` migration so CI publishes updated manifests

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
