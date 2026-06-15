#!/usr/bin/with-contenv bashio
set -euo pipefail

SHARE_DIR="/share/hailo"
RUNTIME_DIR="/share/hailo-daemon/hailo_packages"
HAILO_SERVICE_BIN="/usr/local/bin/hailort_service"

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

if [ ! -x "${HAILO_SERVICE_BIN}" ]; then
    bashio::log.error "hailort_service binary not found at ${HAILO_SERVICE_BIN}"
    exit 1
fi

HAILO_SOCKET="${SHARE_DIR}/hailo_rt_service.sock"

# Configure hailort_service to create its socket at the shared path
if [ -f /etc/default/hailort_service ]; then
    bashio::log.info "Configuring hailort_service socket path..."
    bashio::log.info "Contents of /etc/default/hailort_service:"
    cat /etc/default/hailort_service
    # Try to set the socket path if the config supports it
    if grep -q "SOCKET" /etc/default/hailort_service; then
        sed -i "s|.*SOCKET.*|HAILORT_SERVICE_ADDRESS=${HAILO_SOCKET}|" /etc/default/hailort_service
    else
        echo "HAILORT_SERVICE_ADDRESS=${HAILO_SOCKET}" >> /etc/default/hailort_service
    fi
    bashio::log.info "Updated config:"
    cat /etc/default/hailort_service
fi

# Also try via environment variable
export HAILORT_SERVICE_ADDRESS="${HAILO_SOCKET}"

bashio::log.info "Starting hailort_service (driver ${DRIVER_VERSION})..."
"${HAILO_SERVICE_BIN}"

# Wait for the socket to appear
for i in $(seq 1 20); do
    [ -S "${HAILO_SOCKET}" ] && break
    # Also check default location in case config was ignored
    if [ -S /tmp/hailort_uds.sock ]; then
        bashio::log.warning "Service created socket at default location — config key may differ"
        bashio::log.warning "Contents of /etc/default/hailort_service:"
        cat /etc/default/hailort_service || true
        bashio::log.error "Cannot share socket across containers from /tmp — check config above"
        exit 1
    fi
    sleep 0.5
done

if [ ! -S "${HAILO_SOCKET}" ]; then
    bashio::log.error "hailort_service did not create socket at ${HAILO_SOCKET}"
    exit 1
fi

bashio::log.info "hailort_service ready — socket at ${HAILO_SOCKET}"

# Keep container alive; exit if the socket disappears
while [ -S "${HAILO_SOCKET}" ]; do
    sleep 5
done

bashio::log.error "hailort_service socket disappeared — service likely crashed"
exit 1
