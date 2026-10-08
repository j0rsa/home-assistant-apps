#!/usr/bin/env bash
set -euo pipefail

# Authentication is handled by Home Assistant ingress — disable the built-in login.
export DISABLE_AUTHENTICATION=true

# Run as root so the entrypoint's UID/GID management is a no-op.
export PUID=0
export PGID=0

# Borgui stores all persistent state under /data.
# HA mounts app_config at /config; redirect /data there so data survives restarts.
if [ ! -L /data ]; then
    rm -rf /data
    ln -sf /config /data
fi

# Expose HA volumes as local mount points borgui can browse and back up.
export LOCAL_MOUNT_POINTS=/share,/backup,/media

exec /entrypoint.sh
