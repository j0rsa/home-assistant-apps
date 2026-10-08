# Changelog

## 0.0.9

- Rename app from Borg to BorgUI; slug and image changed to borgui
- Change sidebar icon to mdi:backup-restore

## 0.0.8

- Replace proxy auth with ALLOW_INSECURE_NO_AUTH: HA ingress handles auth, no multi-user needed

## 0.0.7

- Fix proxy auth: set PROXY_AUTH_HEADER=X-Hass-User-ID so borgui reads HA's user header instead of expecting X-Forwarded-User

## 0.0.6

- Fix ingress BASE_PATH: fetch real ingress_entry from HA Supervisor API at startup
  (hostname is the slug, not the ingress token; SUPERVISOR_TOKEN gives the correct path)

## 0.0.5

- Fix ingress asset/API paths: set BASE_PATH from container hostname (HA token — was wrong)
- App rewrites index.html and injects window.__BASE_PATH__ at startup for correct routing

## 0.0.4

- Fix apt package names for Ubuntu 26.04: libcrypt1 (was libxcrypt1), drop libfuse3-3 (fuse3 pulls libfuse3-4)

## 0.0.3

- Fix missing Python extension libs (libsqlite3, liblzma, libbz2, libreadline, libncursesw, etc.)
- Replace libfuse3-dev with libfuse3-3 (runtime library only)

## 0.0.2

- Fix privileged field: use list format `[SYS_ADMIN]` instead of boolean (HA Supervisor requirement)
- Fix startup: replace /data symlink approach with DATA_DIR=/config (HA auto-mounts /data)

## 0.0.1

- Add initial Home Assistant app release based on ainullcode/borg-ui:edge
- Bundles borg 1.4.5, borg2 2.0.0b25, and rclone 1.75.0
- Add ingress support with authentication bypass via DISABLE_AUTHENTICATION
- Add access to share, backup, and media volumes as local mount points
- Add ingress support with authentication bypass via DISABLE_AUTHENTICATION
- Add access to share, backup, and media volumes as local mount points
