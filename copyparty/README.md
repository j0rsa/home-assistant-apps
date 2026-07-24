# Copyparty

[Copyparty](https://github.com/9001/copyparty) turns folders into a browser file server with resumable uploads, downloads, and WebDAV.

## Mapped folders

| URL path | Container path | HA mount |
|----------|----------------|----------|
| `/share` | `/share` | `share:rw` |
| `/media` | `/media` | `media:rw` |
| `/addon-config` | `/config` | `addon_config:rw` |
| `/addon-configs` | `/addon_configs` | `all_addon_configs:rw` |
| `/homeassistant` | `/homeassistant` | `homeassistant_config:rw` |
| `/ssl` | `/ssl` | `ssl:ro` |

> Home Assistant’s configuration folder is mapped as `homeassistant_config` (not legacy `config`), because `config` cannot be combined with `addon_config`.

## Configuration

| Option | Description |
|--------|-------------|
| `username` / `password` | Admin account (full access) |
| `anonymous_access` | `none`, `read`, or `readwrite` for guests |
| `enable_indexing` | File + media indexing |
| `server_name` | Name shown in the UI |

Advanced: place extra `*.conf` files in the app config folder (`/config` in the container).

## Access

- Web UI: `http://homeassistant.local:3923/`
- Paths: `/share`, `/media`, `/addon-config`, `/addon-configs`, `/homeassistant`
