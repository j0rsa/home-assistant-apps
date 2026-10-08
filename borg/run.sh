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

# Fetch the real ingress entry path from the HA Supervisor API.
# SUPERVISOR_TOKEN is injected by HA into every add-on container.
# ingress_entry looks like /api/hassio_ingress/{token}.
BASE_PATH=$(curl -sf \
    -H "Authorization: Bearer ${SUPERVISOR_TOKEN}" \
    http://supervisor/addons/self/info \
    | python3 -c "import sys,json; print(json.load(sys.stdin)['data']['ingress_entry'])" \
    2>/dev/null || true)
export BASE_PATH

exec /entrypoint.sh
