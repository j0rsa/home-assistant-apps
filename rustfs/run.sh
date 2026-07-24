#!/usr/bin/with-contenv bashio
# shellcheck shell=bash
set -euo pipefail

bashio::log.info "Starting RustFS..."

ACCESS_KEY=$(bashio::config 'access_key')
SECRET_KEY=$(bashio::config 'secret_key')
VOLUMES=$(bashio::config 'volumes')
CONSOLE_ENABLE=$(bashio::config 'console_enable')
REGION=$(bashio::config 'region')
SERVER_DOMAINS=$(bashio::config 'server_domains')
BROWSER_REDIRECT_URL=$(bashio::config 'browser_redirect_url')
CORS_ORIGINS=$(bashio::config 'cors_allowed_origins')
LOG_LEVEL=$(bashio::config 'log_level')

OIDC_ENABLE=$(bashio::config 'oidc_enable')
OIDC_CONFIG_URL=$(bashio::config 'oidc_config_url')
OIDC_CLIENT_ID=$(bashio::config 'oidc_client_id')
OIDC_CLIENT_SECRET=$(bashio::config 'oidc_client_secret')
OIDC_SCOPES=$(bashio::config 'oidc_scopes')
OIDC_DISPLAY_NAME=$(bashio::config 'oidc_display_name')
OIDC_REDIRECT_URI=$(bashio::config 'oidc_redirect_uri')
OIDC_REDIRECT_URI_DYNAMIC=$(bashio::config 'oidc_redirect_uri_dynamic')
OIDC_GROUPS_CLAIM=$(bashio::config 'oidc_groups_claim')
OIDC_ROLES_CLAIM=$(bashio::config 'oidc_roles_claim')
OIDC_ROLE_POLICY=$(bashio::config 'oidc_role_policy')
OIDC_EMAIL_CLAIM=$(bashio::config 'oidc_email_claim')
OIDC_USERNAME_CLAIM=$(bashio::config 'oidc_username_claim')

if ! bashio::var.has_value "${SECRET_KEY}" || [ "${SECRET_KEY}" = "changeme-use-a-strong-secret" ]; then
    bashio::log.warning "Using default/empty secret_key — change it in the app options before exposing RustFS"
fi

mkdir -p /data /logs /config/logs

IFS=',' read -r -a VOLUME_LIST <<< "${VOLUMES}"
for vol in "${VOLUME_LIST[@]}"; do
    vol_trimmed="$(echo "${vol}" | xargs)"
    [ -z "${vol_trimmed}" ] && continue
    case "${vol_trimmed}" in
        http://*|https://*) continue ;;
    esac
    mkdir -p "${vol_trimmed}"
done

export RUSTFS_ACCESS_KEY="${ACCESS_KEY}"
export RUSTFS_SECRET_KEY="${SECRET_KEY:-changeme-use-a-strong-secret}"
export RUSTFS_VOLUMES="${VOLUMES}"
export RUSTFS_ADDRESS="0.0.0.0:9000"
export RUSTFS_CONSOLE_ADDRESS="0.0.0.0:9001"
export RUSTFS_REGION="${REGION}"
export RUSTFS_OBS_LOGGER_LEVEL="${LOG_LEVEL}"
export RUSTFS_OBS_LOG_DIRECTORY="/logs"
export RUST_LOG="${LOG_LEVEL}"

if bashio::var.true "${CONSOLE_ENABLE}"; then
    export RUSTFS_CONSOLE_ENABLE=true
else
    export RUSTFS_CONSOLE_ENABLE=false
fi

if bashio::var.has_value "${SERVER_DOMAINS}"; then
    export RUSTFS_SERVER_DOMAINS="${SERVER_DOMAINS}"
fi

if bashio::var.has_value "${BROWSER_REDIRECT_URL}"; then
    export RUSTFS_BROWSER_REDIRECT_URL="${BROWSER_REDIRECT_URL}"
fi

if bashio::var.has_value "${CORS_ORIGINS}"; then
    export RUSTFS_CONSOLE_CORS_ALLOWED_ORIGINS="${CORS_ORIGINS}"
fi

if bashio::var.true "${OIDC_ENABLE}"; then
    if ! bashio::var.has_value "${OIDC_CONFIG_URL}" || ! bashio::var.has_value "${OIDC_CLIENT_ID}"; then
        bashio::log.fatal "oidc_enable is true but oidc_config_url / oidc_client_id are missing"
        exit 1
    fi

    export RUSTFS_IDENTITY_OPENID_ENABLE=on
    export RUSTFS_IDENTITY_OPENID_CONFIG_URL="${OIDC_CONFIG_URL}"
    export RUSTFS_IDENTITY_OPENID_CLIENT_ID="${OIDC_CLIENT_ID}"
    export RUSTFS_IDENTITY_OPENID_SCOPES="${OIDC_SCOPES}"
    export RUSTFS_IDENTITY_OPENID_DISPLAY_NAME="${OIDC_DISPLAY_NAME}"
    export RUSTFS_IDENTITY_OPENID_GROUPS_CLAIM="${OIDC_GROUPS_CLAIM}"
    export RUSTFS_IDENTITY_OPENID_EMAIL_CLAIM="${OIDC_EMAIL_CLAIM}"
    export RUSTFS_IDENTITY_OPENID_USERNAME_CLAIM="${OIDC_USERNAME_CLAIM}"

    if bashio::var.true "${OIDC_REDIRECT_URI_DYNAMIC}"; then
        export RUSTFS_IDENTITY_OPENID_REDIRECT_URI_DYNAMIC=true
    else
        export RUSTFS_IDENTITY_OPENID_REDIRECT_URI_DYNAMIC=false
    fi

    if bashio::var.has_value "${OIDC_CLIENT_SECRET}"; then
        export RUSTFS_IDENTITY_OPENID_CLIENT_SECRET="${OIDC_CLIENT_SECRET}"
    fi
    if bashio::var.has_value "${OIDC_REDIRECT_URI}"; then
        export RUSTFS_IDENTITY_OPENID_REDIRECT_URI="${OIDC_REDIRECT_URI}"
    fi
    if bashio::var.has_value "${OIDC_ROLES_CLAIM}"; then
        export RUSTFS_IDENTITY_OPENID_ROLES_CLAIM="${OIDC_ROLES_CLAIM}"
    fi
    if bashio::var.has_value "${OIDC_ROLE_POLICY}"; then
        export RUSTFS_IDENTITY_OPENID_ROLE_POLICY="${OIDC_ROLE_POLICY}"
    fi

    bashio::log.info "OIDC SSO enabled (display name: ${OIDC_DISPLAY_NAME})"
fi

bashio::log.info "Starting RustFS S3 API on :9000 (volumes: ${VOLUMES})"
if bashio::var.true "${CONSOLE_ENABLE}"; then
    bashio::log.info "Console enabled on :9001 (/rustfs/console/)"
fi

# Upstream entrypoint keeps credential validation and volume/log init.
exec /entrypoint.sh
