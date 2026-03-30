#!/usr/bin/with-contenv bashio

set -euo pipefail

SECRETS_FILE="/data/.generated_secrets"

# Generate a random 32-character secret
generate_secret() {
    head -c 32 /dev/urandom | base64 | tr -dc 'a-zA-Z0-9' | head -c 32
}

# Load or generate persistent secrets
load_or_generate_secrets() {
    if [[ -f "${SECRETS_FILE}" ]]; then
        # shellcheck source=/dev/null
        source "${SECRETS_FILE}"
    fi

    local changed=false

    if [[ -z "${GENERATED_MASTER_KEY:-}" ]]; then
        GENERATED_MASTER_KEY="$(generate_secret)"
        changed=true
    fi
    if [[ -z "${GENERATED_ADMIN_PASSWORD:-}" ]]; then
        GENERATED_ADMIN_PASSWORD="$(generate_secret)"
        changed=true
    fi
    if [[ -z "${GENERATED_MQ_PASSWORD:-}" ]]; then
        GENERATED_MQ_PASSWORD="$(generate_secret)"
        changed=true
    fi

    if [[ "${changed}" == "true" ]]; then
        cat > "${SECRETS_FILE}" << EOF
GENERATED_MASTER_KEY="${GENERATED_MASTER_KEY}"
GENERATED_ADMIN_PASSWORD="${GENERATED_ADMIN_PASSWORD}"
GENERATED_MQ_PASSWORD="${GENERATED_MQ_PASSWORD}"
EOF
        chmod 600 "${SECRETS_FILE}"
    fi
}

bashio::log.info "Starting Netmaker Controller..."

# Ensure data directory exists
mkdir -p /data

# Load or generate secrets
load_or_generate_secrets

# Read configuration from HA options
NM_DOMAIN="$(bashio::config 'nm_domain')"
SERVER_HOST="$(bashio::config 'server_host')"
MASTER_KEY="$(bashio::config 'master_key')"
ADMIN_USER="$(bashio::config 'admin_user')"
ADMIN_PASSWORD="$(bashio::config 'admin_password')"
MQ_BROKER_ENDPOINT="$(bashio::config 'mq_broker_endpoint')"
MQ_USERNAME="$(bashio::config 'mq_username')"
MQ_PASSWORD="$(bashio::config 'mq_password')"
DNS_MODE="$(bashio::config 'dns_mode')"
VERBOSITY="$(bashio::config 'verbosity')"
TELEMETRY="$(bashio::config 'telemetry')"

# Use generated secrets if user left fields blank
if [[ -z "${MASTER_KEY}" ]]; then
    MASTER_KEY="${GENERATED_MASTER_KEY}"
    bashio::log.info "Using auto-generated master key (stored in /data/.generated_secrets)"
fi
if [[ -z "${ADMIN_PASSWORD}" ]]; then
    ADMIN_PASSWORD="${GENERATED_ADMIN_PASSWORD}"
    bashio::log.info "Using auto-generated admin password (stored in /data/.generated_secrets)"
fi
if [[ -z "${MQ_PASSWORD}" ]]; then
    MQ_PASSWORD="${GENERATED_MQ_PASSWORD}"
    bashio::log.info "Using auto-generated MQTT password (stored in /data/.generated_secrets)"
fi

# Export Netmaker environment variables
export SERVER_NAME="${NM_DOMAIN}"
export NETMAKER_BASE_DOMAIN="${NM_DOMAIN}"
export SERVER_API_CONN_STRING="${NM_DOMAIN}:443"
export MASTER_KEY
export ADMIN_USER="${ADMIN_USER:-admin}"
export ADMIN_PASSWORD

# Server host (auto-detect if blank)
if [[ -n "${SERVER_HOST}" ]]; then
    export SERVER_HOST
fi

# MQTT client configuration (controller connects TO external MQ broker)
export SERVER_BROKER_ENDPOINT="${MQ_BROKER_ENDPOINT}"
export MQ_USERNAME="${MQ_USERNAME:-netmaker}"
export MQ_PASSWORD

# Database (always SQLite for HA)
export DATABASE="sqlite"
export DB_PATH="/data/netmaker.db"

# DNS mode
if [[ "${DNS_MODE}" == "true" ]]; then
    export DNS_MODE="on"
else
    export DNS_MODE="off"
fi

# Verbosity and telemetry
export VERBOSITY="${VERBOSITY}"
if [[ "${TELEMETRY}" == "true" ]]; then
    export TELEMETRY="on"
else
    export TELEMETRY="off"
fi

# Fixed internal ports
export API_PORT="8081"
export GRPC_PORT="50051"

# Additional defaults
export CORS_ALLOWED_ORIGIN="*"
export INSTALL_TYPE="ce"
export NODE_ID="ha-netmaker-controller"
export DISABLE_REMOTE_IP_CHECK="off"

bashio::log.info "Domain: ${NM_DOMAIN}"
bashio::log.info "MQ Broker (client connecting to): ${MQ_BROKER_ENDPOINT}"
bashio::log.info "Database: SQLite at ${DB_PATH}"
bashio::log.info "API port: ${API_PORT}, gRPC port: ${GRPC_PORT}"
bashio::log.info "DNS mode: ${DNS_MODE}"
bashio::log.info "Verbosity: ${VERBOSITY}"

# Start Netmaker server
exec netmaker
