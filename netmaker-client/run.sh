#!/usr/bin/with-contenv bashio

set -euo pipefail

NETCLIENT_TOKEN=$(bashio::config 'netclient_token')
DEBUG_MODE=$(bashio::config 'debug_mode')
AUTO_RESTART=$(bashio::config 'auto_restart')
HOST_NAME=$(bashio::config 'host_name')

bashio::log.info "Starting Netmaker Client add-on..."

if [[ -z "${NETCLIENT_TOKEN}" ]]; then
    bashio::log.error "Netclient token is required. Please provide a valid netclient_token."
    exit 1
fi

mkdir -p /config/netclient
ln -sfn /config/netclient /etc/netclient

bashio::log.info "Setting up network devices..."
mkdir -p /dev/net || true
if [[ ! -e /dev/net/tun ]]; then
    mknod /dev/net/tun c 10 200
fi

export NETCLIENT_TOKEN
export HOST_NAME

setup_netclient() {
    bashio::log.info "Setting up Netclient..."

    bashio::log.info "Netclient version:"
    netclient version || true

    bashio::log.info "Joining Netmaker network..."
    if ! netclient join -t "${NETCLIENT_TOKEN}" -o "${HOST_NAME}"; then
        bashio::log.warning "Failed to join network or already joined"
    fi

    if [[ "${DEBUG_MODE}" == "true" ]]; then
        bashio::log.info "Current routing table:"
        ip route show || true
        bashio::log.info "Network interfaces:"
        ip link show || true
    fi

    return 0
}

run_daemon() {
    bashio::log.info "Starting Netclient daemon..."
    netclient daemon
}

main_loop() {
    while true; do
        bashio::log.info "Starting Netmaker Client setup..."

        if setup_netclient; then
            bashio::log.info "Netclient setup completed, running daemon"
            run_daemon || bashio::log.error "Netclient daemon exited"
        else
            bashio::log.error "Netclient setup failed"
        fi

        if [[ "${AUTO_RESTART}" == "true" ]]; then
            bashio::log.info "Auto-restart enabled, retrying in 30 seconds..."
            sleep 30
        else
            bashio::log.error "Daemon exited and auto-restart is disabled"
            exit 1
        fi
    done
}

main_loop
