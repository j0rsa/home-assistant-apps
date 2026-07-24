# Changelog

## 1.0.0-1

- Initial release of RustFS S3-compatible object storage
- Build on Home Assistant Ubuntu 26.04 base with bashio; copy glibc RustFS binary from upstream
- Add official RustFS "R" icon and logo
- Expose root access key / secret key, console, region, CORS, and log level options
- Expose OpenID Connect SSO options for console login (config URL, client credentials, claims, redirect URI)
- Mount addon config, Home Assistant config, share, media, and ssl into the container
