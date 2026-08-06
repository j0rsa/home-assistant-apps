# Changelog

## 1.0.0-6

- Remove deprecated `codenotary` field from config and build metadata

## 1.0.0-5

- Restrict mapped volumes to `share:rw` only (object data under `/share/rustfs`)

## 1.0.0-4

- Disable Home Assistant Ingress and remove nginx; console is not ingress-ready (use port 9001 `/rustfs/console/`)

## 1.0.0-3

- Fix Home Assistant Ingress 404 by proxying via nginx (`nginx.conf`) and opening `/rustfs/console/` (console is not served at `/`)

## 1.0.0-2

- Default object store path (`volumes`) to `/share/rustfs`

## 1.0.0-1

- Initial release of RustFS S3-compatible object storage
- Build on Home Assistant Ubuntu 26.04 base with bashio; copy glibc RustFS binary from upstream
- Add official RustFS "R" icon and logo
- Expose root access key / secret key, console, region, CORS, and log level options
- Expose OpenID Connect SSO options for console login (config URL, client credentials, claims, redirect URI)
- Mount addon config, Home Assistant config, share, media, and ssl into the container
