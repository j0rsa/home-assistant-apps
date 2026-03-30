#!/usr/bin/with-contenv bashio

set -euo pipefail

bashio::log.info "Starting Netmaker Dashboard UI..."

BACKEND_URL="$(bashio::config 'backend_url')"

if [[ -n "${BACKEND_URL}" ]]; then
    export BACKEND_URL
    bashio::log.info "Backend API URL: ${BACKEND_URL}"
else
    bashio::log.info "Backend URL not set; UI will use its default API endpoint"
fi

# Ensure nginx directories exist
mkdir -p /run/nginx /var/log/nginx

bashio::log.info "Dashboard available on port 80"

# Start nginx in foreground
exec nginx -g 'daemon off;'
