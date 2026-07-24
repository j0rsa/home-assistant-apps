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
    a: "Open /homeassistant for HA config, /share for the share folder, /media for media, /addon-config for this app's public config, and /addon-configs for every app's public config folder."
  - q: "Why is there no /config URL for Home Assistant?"
    a: "Supervisor maps HA config as homeassistant_config → /homeassistant when addon_config is also used."
  - q: "Can guests upload without login?"
    a: "Set anonymous_access to readwrite. Prefer none on networks you do not trust."
---

# Copyparty

[Copyparty](https://github.com/9001/copyparty) is a portable file server with a rich browser UI. Use it when you need to expose real directories (share, media, Home Assistant config) with uploads and WebDAV — unlike S3 object storage.

## Features

- Browse and upload files from a web browser
- Resumable uploads / downloads
- WebDAV on the same port
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
| Share | `http://homeassistant.local:3923/share/` |
| Media | `http://homeassistant.local:3923/media/` |
| HA config | `http://homeassistant.local:3923/homeassistant/` |
| App config | `http://homeassistant.local:3923/addon-config/` |
| All app configs | `http://homeassistant.local:3923/addon-configs/` |

## Configuration

```yaml
username: admin
password: "replace-with-a-strong-password"
anonymous_access: none   # none | read | readwrite
enable_indexing: true
server_name: homeassistant
```

### Mapped folders

| Path in container | Source | Access |
|-------------------|--------|--------|
| `/config` | App public config (`addon_config`) | writable |
| `/addon_configs` | All apps' public configs (`all_addon_configs`) | writable |
| `/homeassistant` | Home Assistant configuration | writable |
| `/share` | Shared folder | writable |
| `/media` | Media folder | writable |
| `/ssl` | TLS certificates | read-only |

## Security

- Change the default password before opening port 3923 outside your LAN
- Keep `anonymous_access: none` unless you intentionally want guest uploads
- Granting write access to `/homeassistant` can break Home Assistant if files are edited carelessly

## Support

- Upstream: [https://github.com/9001/copyparty](https://github.com/9001/copyparty)
- App repository: [https://github.com/j0rsa/home-assistant-apps](https://github.com/j0rsa/home-assistant-apps)
