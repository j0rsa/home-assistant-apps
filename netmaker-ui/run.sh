#!/usr/bin/with-contenv bashio

set -euo pipefail

bashio::log.info "Starting Netmaker Dashboard UI..."

BACKEND_URL="$(bashio::config 'backend_url')"

if [[ -n "${BACKEND_URL}" ]]; then
    bashio::log.info "Backend API URL: ${BACKEND_URL}"
    # Inject BACKEND_URL into the UI's environment config
    # The React app reads window._env_ or environment.js at runtime
    cat > /usr/share/nginx/html/env.js << EOF
window.__NETMAKER_BACKEND_URL__ = "${BACKEND_URL}";
window.NETMAKER_BACKEND_URL = "${BACKEND_URL}";
EOF
    # Also replace any placeholder backend URLs in the built JS files
    find /usr/share/nginx/html -name '*.js' -exec sed -i "s|https://api.netmaker.example.com|${BACKEND_URL}|g" {} + 2>/dev/null || true
else
    bashio::log.info "Backend URL not set; UI will use its default API endpoint"
fi

# Ensure nginx directories exist
mkdir -p /run/nginx /var/log/nginx

# Write nginx config for serving the SPA and proxying API to backend
cat > /etc/nginx/http.d/default.conf << NGINX
server {
    listen 80;
    server_name _;

    root /usr/share/nginx/html;
    index index.html;

    # Proxy API requests to the Netmaker Controller backend
    location /api {
        proxy_pass ${BACKEND_URL};
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }

    # Serve static SPA files
    location / {
        try_files \$uri \$uri/ /index.html;
    }

    # Cache static assets
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg|woff|woff2|ttf|eot)\$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }
}
NGINX

bashio::log.info "Dashboard available on port 80"

# Start nginx in foreground
exec nginx -g 'daemon off;'
