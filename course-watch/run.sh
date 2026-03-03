#!/usr/bin/with-contenv bashio

WEBDAV_USER=$(bashio::config 'webdav_user')
WEBDAV_PASS=$(bashio::config 'webdav_password')
MEDIA_URL=$(bashio::config 'media_url')

# ── Nginx auth header ──────────────────────────────────────────────
if bashio::config.has_value 'webdav_user'; then
    WEBDAV_AUTH=$(printf '%s:%s' "${WEBDAV_USER}" "${WEBDAV_PASS}" | base64 -w0)
    export WEBDAV_AUTH_LINE="proxy_set_header Authorization \"Basic ${WEBDAV_AUTH}\";"
    bashio::log.info "WebDAV auth enabled for user: ${WEBDAV_USER}"
else
    export WEBDAV_AUTH_LINE="# no WebDAV auth"
    bashio::log.warning "No WebDAV credentials configured — proxy will send unauthenticated requests"
fi

# ── Media URL (strip trailing slash) ───────────────────────────────
export MEDIA_URL="${MEDIA_URL%/}"

# ── Generate nginx config ─────────────────────────────────────────
envsubst '${WEBDAV_AUTH_LINE}' \
    < /etc/nginx/templates/nginx.conf.template \
    > /etc/nginx/nginx.conf

if [ -n "${MEDIA_URL}" ]; then
    envsubst '${MEDIA_URL} ${WEBDAV_AUTH_LINE}' \
        < /etc/nginx/templates/media-proxy.conf.template \
        > /etc/nginx/conf.d/media-proxy.conf
    bashio::log.info "Media URL: ${MEDIA_URL}"
else
    echo '# media_url not configured — only absolute proxy URLs are supported' \
        > /etc/nginx/conf.d/media-proxy.conf
    bashio::log.info "Media URL: (none, absolute URLs only)"
fi

mkdir -p /share/course-watch

bashio::log.info "Starting Course Watch (nginx)..."
bashio::log.info "Courses file: /share/course-watch/courses.json"
bashio::log.info "Web UI available on port 8099"

exec nginx -g 'daemon off;'
