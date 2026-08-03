# Changelog

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
