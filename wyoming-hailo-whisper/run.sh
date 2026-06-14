#!/usr/bin/with-contenv bashio
set -euo pipefail

APP_DIR="/opt/wyoming-hailo-whisper"
SHARE_DIR="/share/wyoming-hailo-whisper"
RUNTIME_DIR="${SHARE_DIR}/hailo_packages"
MODELS_DIR="${SHARE_DIR}/models"
APP_RESOURCE_DIR="${APP_DIR}/wyoming_hailo_whisper/app"
VARIANT="$(bashio::config 'variant')"
DEVICE="$(bashio::config 'device')"
LANGUAGE="$(bashio::config 'language')"

bashio::log.info "Starting Wyoming Hailo Whisper"
bashio::log.info "Variant: ${VARIANT}"
bashio::log.info "Device: ${DEVICE}"
bashio::log.info "Language: ${LANGUAGE}"

mkdir -p "${RUNTIME_DIR}" "${MODELS_DIR}"

if [ ! -e /dev/hailo0 ]; then
    bashio::log.error "Hailo device /dev/hailo0 is not available"
    exit 1
fi

PYTHON_TAG="$("${APP_DIR}/.venv/bin/python" -c 'import sys; v=sys.version_info; print(f"cp{v.major}{v.minor}")')"

if ! ldconfig -p | grep -q "libhailort.so"; then
    if ! ls "${RUNTIME_DIR}"/*.deb >/dev/null 2>&1; then
        bashio::log.error "HailoRT native library (libhailort.so) is not installed"
        bashio::log.error "The Python wheel alone is not enough — you also need the HailoRT Debian package:"
        bashio::log.error "  1. Download hailort_4.x.x_arm64.deb from https://developer.hailo.ai"
        bashio::log.error "     (same version as your firmware: hailortcli fw-control identify)"
        bashio::log.error "  2. Place the .deb file into ${RUNTIME_DIR}/"
        bashio::log.error "  3. Restart this app"
        exit 1
    fi
    bashio::log.info "Installing HailoRT Debian package..."
    dpkg -i "${RUNTIME_DIR}"/*.deb
    ldconfig
fi

_print_wheel_instructions() {
    bashio::log.error "To fix this:"
    bashio::log.error "  1. Register at https://developer.hailo.ai"
    bashio::log.error "  2. Go to Downloads -> Software -> HailoRT"
    bashio::log.error "  3. Download both files matching your firmware version (hailortcli fw-control identify):"
    bashio::log.error "       hailort_4.x.x_arm64.deb"
    bashio::log.error "       hailort-4.x.x-${PYTHON_TAG}-${PYTHON_TAG}-linux_aarch64.whl"
    bashio::log.error "  4. Place both files into ${RUNTIME_DIR}/"
    bashio::log.error "  5. Restart this app"
}

if ! ls "${RUNTIME_DIR}"/*.whl >/dev/null 2>&1; then
    bashio::log.error "Missing Hailo Python wheel in ${RUNTIME_DIR}"
    _print_wheel_instructions
    exit 1
fi

# Validate the wheel is compatible with the running Python before attempting install
for whl in "${RUNTIME_DIR}"/*.whl; do
    if [[ "$(basename "${whl}")" != *"${PYTHON_TAG}"* && "$(basename "${whl}")" != *"py3"* && "$(basename "${whl}")" != *"py2.py3"* ]]; then
        bashio::log.error "Wheel $(basename "${whl}") is not compatible with Python ${PYTHON_TAG}"
        _print_wheel_instructions
        exit 1
    fi
done

CURRENT_WHEEL_FINGERPRINT="$(ls -1 "${RUNTIME_DIR}"/*.whl | sort | sha256sum | awk '{print $1}')"
INSTALLED_WHEEL_FINGERPRINT=""
if [ -f "${APP_DIR}/.hailo-runtime-wheel.sha256" ]; then
    INSTALLED_WHEEL_FINGERPRINT="$(cat "${APP_DIR}/.hailo-runtime-wheel.sha256")"
fi

if [ "${CURRENT_WHEEL_FINGERPRINT}" != "${INSTALLED_WHEEL_FINGERPRINT}" ]; then
    bashio::log.info "Installing Hailo Python runtime wheel from ${RUNTIME_DIR}"
    "${APP_DIR}/.venv/bin/pip" install --no-cache-dir --force-reinstall "${RUNTIME_DIR}"/*.whl
    printf '%s' "${CURRENT_WHEEL_FINGERPRINT}" > "${APP_DIR}/.hailo-runtime-wheel.sha256"
fi

if [ ! -d "${MODELS_DIR}/hefs" ] || [ ! -d "${MODELS_DIR}/decoder_assets" ]; then
    bashio::log.info "Whisper model resources not found in ${MODELS_DIR}; downloading them now"
    (cd "${APP_RESOURCE_DIR}" && ./download_resources.sh "${MODELS_DIR}")
fi

if [ ! -L "${APP_RESOURCE_DIR}/hefs" ]; then
    rm -rf "${APP_RESOURCE_DIR}/hefs"
    ln -s "${MODELS_DIR}/hefs" "${APP_RESOURCE_DIR}/hefs"
fi

if [ ! -L "${APP_RESOURCE_DIR}/decoder_assets" ]; then
    rm -rf "${APP_RESOURCE_DIR}/decoder_assets"
    ln -s "${MODELS_DIR}/decoder_assets" "${APP_RESOURCE_DIR}/decoder_assets"
fi

bashio::log.info "Launching Wyoming Hailo Whisper on 0.0.0.0:10600"
exec "${APP_DIR}/.venv/bin/python" -m wyoming_hailo_whisper \
    --uri 'tcp://0.0.0.0:10600' \
    --device "${DEVICE}" \
    --variant "${VARIANT}" \
    --language "${LANGUAGE}"
