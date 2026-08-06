# Copyparty

[Copyparty](https://github.com/9001/copyparty) turns folders into a browser file server with resumable uploads, downloads, and WebDAV.

## Mapped folders

Matches `map:` in `config.yaml`:

| URL path | Container path | HA mount |
|----------|----------------|----------|
| `/app-config` | `/config` | `app_config:rw` |
| `/app-configs` | `/app_configs` | `all_app_configs:rw` |
| `/homeassistant` | `/homeassistant` | `homeassistant_config:rw` |
| `/share` | `/share` | `share:rw` |
| `/backup` | `/backup` | `backup:rw` |
| `/media` | `/media` | `media:rw` |
| `/ssl` | `/ssl` | `ssl:ro` |

> Home Assistant’s configuration folder is mapped as `homeassistant_config` (not legacy `config`), because `config` cannot be combined with `app_config`.

## Configuration

| Option | Description |
|--------|-------------|
| `password` | Password for the hardcoded `admin` account (full access) |
| `readonly_password` | Password for the hardcoded `readonly` account (read-only). Leave empty to disable |
| `anonymous_access` | `none`, `read`, or `readwrite` for guests |
| `enable_indexing` | File + media indexing |
| `server_name` | Name shown in the UI |

Accounts:
- `admin` — read/write/move/delete/admin on all volumes (`/ssl` is read-only)
- `readonly` — read-only on all volumes (enabled when `readonly_password` is set)

Advanced: place extra `*.conf` files in the app config folder (`/config` in the container).

## Access

- Web UI: `http://homeassistant.local:3923/`
- Paths: `/app-config`, `/app-configs`, `/homeassistant`, `/share`, `/backup`, `/media`, `/ssl` (read-only)
