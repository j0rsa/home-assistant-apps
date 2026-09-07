# Changelog

## 1.20.23

- Update upstream from `1.20.21` to `1.20.23` ([compare](https://github.com/9001/copyparty/compare/v1.20.21...v1.20.23))
- hello fedora ([notes](https://github.com/9001/copyparty/releases/tag/v1.20.22))
- [v1.20.19 (2026-07-27)](https://github.com/9001/copyparty/releases/tag/v1.20.19) fixed an FTP-server vuln (upload outside defined volumes)
- [v1.20.17 (2026-07-06)](https://github.com/9001/copyparty/releases/tag/v1.20.17) fixed a vuln when a volume has both filekeys and dirkeys enabled
- [v1.20.17 (2026-07-06)](https://github.com/9001/copyparty/releases/tag/v1.20.17) introduced csp nonces, possibly breaking some javascript-based plugins
- iPhone: new bug in iOS breaks uploading; add workaround
- apple broke XHR/fetch in a recent iOS version by introducing some wtf race-conditions in response handling; under high network load, the browser simply forgets to tell js that there's a response, so we're basically flying blind
- this workaround makes iOS uploads 50x faster than before but still not perfect (impossible given the situation); will be stuttery until apple fixes iOS
- apple will probably fix it very soon given the severity of the bug, but at least one copyparty user is forever-stuck on iOS-18.x which will never be fixed by apple, so a workaround is justified
- #1617 new plugin to thumbnail office documents with collabora (thx @kamaeff!)
- new hook: [phonecam-sorter.py](https://github.com/9001/copyparty/blob/hovudstraum/bin/hooks/phonecam-sorter.py) to automate organizing of pics/vids synced from phone to nas
- dirkeys: allow non-recursive download-as-zip with just `dk`
- `--no-mime` / volflag `nomime` disables `?mime=` for specifying custom response mimetype
- btrfs-specific: nocow .hist to improve sqlite performance
- two low-severity vulns in different components, but surprisingly similar synopses:
- GHSA-mc69-pxc8-4xf4 dirkeys (volflag `dk`) did not prevent descending into subdirs if an attacker could guess the name of the subdir
- GHSA-3fhv-rhjw-7hrg sftp did not fully enforce volflags xvol/xdev; an attacker could read a file inside the symlink destination if they could guess the name inside
- not important enough to be listed in "recent important news", but will be detected by the (default-disabled) [version-checker](https://github.com/9001/copyparty/#version-checker)
- #1628 fix http206 range-request for last-n-bytes
- #1610 autogrid didn't count jxl images (thx @sylfn!)
- when running without `e2d`, a config-reload would block uploads
- really old chrome versions (before ver.62) was only able to upload over https
- #1632 connect-page: adjust rclone commands to support long passwords
- packaging: fix jank in source tarballs
- packaging: don't list licenses of unvendored modules
- #1631 systemd-examples: move config to `/etc/copyparty.conf`
- reduce binary-garbage in logs from scrapers/scanners
- sfx: prefer `~/.cache/` (set `PRTY_XD=/tmp` to override)
- sfx: mention https://copyparty.eu/sfx-wtf/ in the header
- reduce complaining in log about default/unsafe tls-certs when not relevant
- #887 copyparty has been packaged for Fedora 44! And EPEL-10 is on the way too... Thx @supakeen o/
- [verified at RevSpace NL](https://a.ocv.me/pub/g/2026/09/20260901_151949.jpg?cache)
- rcm once again ([notes](https://github.com/9001/copyparty/releases/tag/v1.20.23))
- [v1.20.19 (2026-07-27)](https://github.com/9001/copyparty/releases/tag/v1.20.19) fixed an FTP-server vuln (upload outside defined volumes)
- [v1.20.17 (2026-07-06)](https://github.com/9001/copyparty/releases/tag/v1.20.17) fixed a vuln when a volume has both filekeys and dirkeys enabled
- [v1.20.17 (2026-07-06)](https://github.com/9001/copyparty/releases/tag/v1.20.17) introduced csp nonces, possibly breaking some javascript-based plugins
- the custom right-click-menu didn't like being enabled
- this release is a hotfix for that; see [v1.20.22](https://github.com/9001/copyparty/releases/tag/v1.20.22) for all the other new stuff
- #887 copyparty has been packaged for Fedora 44! And EPEL-10 is on the way too... Thx @supakeen o/
- [verified at RevSpace NL](https://a.ocv.me/pub/g/2026/09/20260901_151949.jpg?cache)
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
