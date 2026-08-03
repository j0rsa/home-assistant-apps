# Changelog

## 1.6.0-1

- Fail the image build if netclient download fails, is empty, or is not an ELF binary
- Fix netclient download URL (`releases/download/v1.6.0/...`)
- Fail the image build if the downloaded binary is not a working netclient

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
