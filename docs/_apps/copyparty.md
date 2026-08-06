---
name: copyparty
title: Copyparty - File Server
description: "Browser file server for Home Assistant folders with uploads, WebDAV, and optional accounts."
category: Backup & Storage
version: latest
architectures:
  - amd64
  - aarch64
ports:
  - 3923
faq:
  - q: "Where are my Home Assistant files?"
    a: "Open /homeassistant for HA config, /share, /media, /backup, /app-config for this app's public config, /app-configs for every app's public config, and /ssl for certificates (read-only)."
  - q: "Why is there no /config URL for Home Assistant?"
    a: "Supervisor maps HA config as homeassistant_config → /homeassistant when app_config is also used. This app's own public config is at /app-config → /config."
  - q: "Can guests upload without login?"
    a: "Set anonymous_access to readwrite. Prefer none on networks you do not trust. /ssl stays login-only even when anonymous write is enabled."
  - q: "How do I give someone browse-only access?"
    a: "Set readonly_password and log in as user readonly. That account can read all volumes but cannot upload, move, or delete."
---

# Copyparty

[Copyparty](https://github.com/9001/copyparty) is a portable file server with a rich browser UI. Use it when you need to expose real directories (share, media, backups, Home Assistant and app configs) with uploads and WebDAV — unlike S3 object storage.

## Features

- Browse and upload files from a web browser
- Resumable uploads / downloads
- WebDAV on the same port
- Optional `readonly` login for browse/download-only access
- Optional guest read or read-write access
- File indexing and multimedia thumbnails (ffmpeg)

## Installation

1. Add the J0rsa repository to Home Assistant
2. Install **Copyparty**
3. Set a strong `password`
4. Start the app

## Access

| Endpoint | URL |
|----------|-----|
| Web UI | `http://homeassistant.local:3923/` |
| App config | `http://homeassistant.local:3923/app-config/` |
| All app configs | `http://homeassistant.local:3923/app-configs/` |
| HA config | `http://homeassistant.local:3923/homeassistant/` |
| Share | `http://homeassistant.local:3923/share/` |
| Backups | `http://homeassistant.local:3923/backup/` |
| Media | `http://homeassistant.local:3923/media/` |
| SSL certs | `http://homeassistant.local:3923/ssl/` (read-only) |

## Configuration

```yaml
password: "replace-with-a-strong-password"
readonly_password: "optional-readonly-password"
anonymous_access: none   # none | read | readwrite
enable_indexing: true
server_name: homeassistant
```

Accounts:
- `admin` — full access (`rwmda`) on writable volumes; read-only on `/ssl`
- `readonly` — read-only on all volumes; created only when `readonly_password` is set

### Mapped folders

| URL path | Path in container | Source | Access |
|----------|-------------------|--------|--------|
| `/app-config` | `/config` | App public config (`app_config`) | writable |
| `/app-configs` | `/app_configs` | All apps' public configs (`all_app_configs`) | writable |
| `/homeassistant` | `/homeassistant` | Home Assistant configuration | writable |
| `/share` | `/share` | Shared folder | writable |
| `/backup` | `/backup` | Home Assistant backups | writable |
| `/media` | `/media` | Media folder | writable |
| `/ssl` | `/ssl` | TLS certificates (`ssl`) | read-only |

## Security

- Change the default password before opening port 3923 outside your LAN
- Use `readonly` for browse/download-only access instead of sharing the admin password
- Keep `anonymous_access: none` unless you intentionally want guest uploads
- Write access to `/homeassistant`, `/backup`, and `/app-configs` can break Home Assistant or other apps if files are edited carelessly

## Support

- Upstream: [https://github.com/9001/copyparty](https://github.com/9001/copyparty)
- App repository: [https://github.com/j0rsa/home-assistant-apps](https://github.com/j0rsa/home-assistant-apps)
