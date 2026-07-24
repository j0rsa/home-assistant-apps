# RustFS

High-performance, S3-compatible object storage powered by [RustFS](https://rustfs.com/) — a Rust MinIO alternative.

Built on the Home Assistant Ubuntu base image with bashio; the RustFS glibc binary is copied from the upstream image.

## Features

- S3 API on port **9000**
- Web console on port **9001** at `/rustfs/console/` (direct access; not ingress-compatible)
- Optional OpenID Connect SSO for console login
- Access to Home Assistant `config`, `share`, `media`, and app config folders

## Configuration

| Option | Description |
|--------|-------------|
| `access_key` / `secret_key` | Root credentials (change the default secret) |
| `volumes` | Object store data path(s), default `/share/rustfs` |
| `console_enable` | Enable the web console |
| `region` | S3 region string |
| `server_domains` | Virtual-hosted-style domains (comma-separated) |
| `browser_redirect_url` | Public console URL for OIDC redirects |
| `cors_allowed_origins` | Console CORS origins |
| `log_level` | `error` / `warn` / `info` / `debug` / `trace` |
| `oidc_*` | OpenID Connect SSO settings (see docs) |

## Volumes mapped into the container

| Host (HA) | Container path |
|-----------|----------------|
| Share | `/share` |
| App data | `/data` (always present) |

Point `volumes` at `/share/rustfs` (default) or another path under `/share`.

## Quick S3 client test

```bash
mc alias set rustfs http://homeassistant.local:9000 <access_key> <secret_key>
mc mb rustfs/mybucket
mc ls rustfs
```
