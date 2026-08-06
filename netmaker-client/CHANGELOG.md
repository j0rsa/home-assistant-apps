# Changelog

## 1.6.0-4

- Remove deprecated `codenotary` field from config and build metadata
- Replace legacy `addon_config` map type with `app_config`

## 1.6.0-3

- Use host networking so netclient can manage WireGuard on the HA host

## 1.6.0-2

- Do not run `netclient version` during image build (it initializes WireGuard and fails in CI)

## 1.6.0-1

- Fail the image build if netclient download fails, is empty, or is not an ELF binary
- Fix netclient download URL (`releases/download/v1.6.0/...`)

## 1.6.0

- Remove SOCKS proxy, redsocks, and tun2socks integration
- Run plain netclient join + daemon only
- Remove `socks_proxy`, `wg_2_socks_proxy`, `wg_interface`, and `log_level` options

## 1.5.2

- Update base image to Alpine 3.24

## 1.1.0

- Rename add-on from netmaker to netmaker-client to avoid naming clash with new controller add-on

## 1.0.13

- Remove armv7 architecture support
