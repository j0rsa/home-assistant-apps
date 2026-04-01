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

if ! ls "${RUNTIME_DIR}"/*.whl >/dev/null 2>&1; then
    bashio::log.error "Missing Hailo Python wheel in ${RUNTIME_DIR}"
    bashio::log.error "Please place the ARM64 HailoRT Python wheel into ${RUNTIME_DIR}"
    exit 1
fi

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

if [ ! -L "${APP_RESOURCE_DIR}/hefs" ]; then
    rm -rf "${APP_RESOURCE_DIR}/hefs"
    ln -s "${MODELS_DIR}/hefs" "${APP_RESOURCE_DIR}/hefs"
fi

if [ ! -L "${APP_RESOURCE_DIR}/decoder_assets" ]; then
    rm -rf "${APP_RESOURCE_DIR}/decoder_assets"
    ln -s "${MODELS_DIR}/decoder_assets" "${APP_RESOURCE_DIR}/decoder_assets"
fi

if [ ! -d "${MODELS_DIR}/hefs" ] || [ ! -d "${MODELS_DIR}/decoder_assets" ]; then
    bashio::log.info "Whisper model resources not found in ${MODELS_DIR}; downloading them now"
    (cd "${APP_RESOURCE_DIR}" && ./download_resources.sh)
fi

bashio::log.info "Launching Wyoming Hailo Whisper on 0.0.0.0:10600"
exec "${APP_DIR}/.venv/bin/python" -m wyoming_hailo_whisper \
    --uri 'tcp://0.0.0.0:10600' \
    --device "${DEVICE}" \
    --variant "${VARIANT}" \
    --language "${LANGUAGE}"
