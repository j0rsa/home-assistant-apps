#!/usr/bin/with-contenv bashio
set -euo pipefail

CONNECT_ADDR="$(bashio::config 'connect_addr')"
VLESS_MODE="$(bashio::config 'vless_mode')"

if [[ -z "${CONNECT_ADDR}" ]]; then
    bashio::log.error "connect_addr is required"
    exit 1
fi

bashio::log.info "Starting VK TURN Proxy"
bashio::log.info "Forwarding to ${CONNECT_ADDR}"

export CONNECT_ADDR
if [[ "${VLESS_MODE}" == "true" ]]; then
    bashio::log.info "VLESS mode enabled"
    export VLESS_MODE="true"
else
    export VLESS_MODE="false"
fi

exec /app/docker-entrypoint.sh
