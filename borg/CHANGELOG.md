# Changelog

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
