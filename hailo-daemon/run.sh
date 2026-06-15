#!/usr/bin/with-contenv bashio
set -euo pipefail

SHARE_DIR="/share/hailo"
RUNTIME_DIR="/share/hailo-daemon/hailo_packages"
HAILO_SOCKET=/var/run/hailo_rt_service.sock
HAILO_SOCKET_SHARED="${SHARE_DIR}/hailo_rt_service.sock"

bashio::log.info "Starting Hailo Daemon"

mkdir -p "${SHARE_DIR}" "${RUNTIME_DIR}"

if [ ! -e /dev/hailo0 ]; then
    bashio::log.error "Hailo device /dev/hailo0 is not available"
    exit 1
fi

if ! ldconfig -p | grep -q "libhailort.so"; then
    if ! ls "${RUNTIME_DIR}"/*.deb >/dev/null 2>&1; then
        bashio::log.error "HailoRT Debian package not found in ${RUNTIME_DIR}"
        bashio::log.error "  1. Download hailort_4.x.x_arm64.deb from https://developer.hailo.ai"
        bashio::log.error "     (match the version to your firmware: hailortcli fw-control identify)"
        bashio::log.error "  2. Place the .deb file into ${RUNTIME_DIR}/"
        bashio::log.error "  3. Restart this app"
        exit 1
    fi
    bashio::log.info "Installing HailoRT Debian package..."
    dpkg -i "${RUNTIME_DIR}"/*.deb
    ldconfig
fi

# Verify driver and library versions match
DRIVER_VERSION="$(cat /sys/module/hailo_pci/version 2>/dev/null || echo unknown)"
LIB_VERSION="$(ldconfig -p | grep -oP 'libhailort\.so\.\K[0-9]+\.[0-9]+\.[0-9]+' | head -1 || echo unknown)"
if [ "${DRIVER_VERSION}" != "unknown" ] && [ "${LIB_VERSION}" != "unknown" ] && [ "${DRIVER_VERSION}" != "${LIB_VERSION}" ]; then
    bashio::log.error "HailoRT version mismatch: kernel driver is ${DRIVER_VERSION} but libhailort is ${LIB_VERSION}"
    bashio::log.error "Replace the .deb in ${RUNTIME_DIR}/ with version ${DRIVER_VERSION}"
    bashio::log.error "See: https://github.com/hailo-ai/hailort-drivers"
    exit 1
fi

if ! command -v hailortd >/dev/null 2>&1; then
    bashio::log.error "hailortd binary not found — is the .deb correctly installed?"
    exit 1
fi

bashio::log.info "Starting hailortd (driver ${DRIVER_VERSION})..."
hailortd &
HAILORTD_PID=$!

# Wait up to 5 seconds for socket
for i in $(seq 1 10); do
    [ -S "${HAILO_SOCKET}" ] && break
    sleep 0.5
done

if [ ! -S "${HAILO_SOCKET}" ]; then
    bashio::log.error "hailortd did not create socket at ${HAILO_SOCKET}"
    exit 1
fi

ln -sf "${HAILO_SOCKET}" "${HAILO_SOCKET_SHARED}"
bashio::log.info "hailortd ready — socket exposed at ${HAILO_SOCKET_SHARED}"

# Keep container alive and exit if hailortd dies
wait "${HAILORTD_PID}"
bashio::log.error "hailortd exited unexpectedly"
exit 1
