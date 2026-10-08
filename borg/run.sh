#!/usr/bin/env bash
set -euo pipefail

# Authentication is handled by Home Assistant ingress — disable the built-in login.
export DISABLE_AUTHENTICATION=true

# Run as root so the entrypoint's UID/GID management is a no-op.
export PUID=0
export PGID=0

# HA Supervisor auto-mounts a volume at /data — it cannot be removed or symlinked.
# Override DATA_DIR so borgui persists its state in app_config (/config) instead.
export DATA_DIR=/config
mkdir -p /config/ssh_keys /config/borg_keys /config/logs /config/config

# Expose HA volumes as local mount points borgui can browse and back up.
export LOCAL_MOUNT_POINTS=/share,/backup,/media

# HA sets HOSTNAME=<token_with_hyphens>; the ingress URL uses underscores.
# BASE_PATH makes the app rewrite index.html asset paths at startup and
# injects window.__BASE_PATH__ so the React app prefixes all API calls.
export BASE_PATH="/api/hassio_ingress/$(hostname | tr '-' '_')"

exec /entrypoint.sh
