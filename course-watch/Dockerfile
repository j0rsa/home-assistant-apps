ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base:3.23
FROM ${BUILD_FROM}

ARG BUILD_VERSION
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF

RUN apk add --no-cache nginx gettext \
    && mkdir -p /app/www /etc/nginx/templates /etc/nginx/conf.d /run/nginx

COPY nginx.conf.template       /etc/nginx/templates/nginx.conf.template
COPY media-proxy.conf.template /etc/nginx/templates/media-proxy.conf.template
COPY www/ /app/www/
COPY run.sh /
RUN chmod a+x /run.sh

EXPOSE 8099

CMD ["/run.sh"]

LABEL \
  io.hass.version="${BUILD_VERSION}" \
  io.hass.type="addon" \
  io.hass.arch="${BUILD_ARCH}" \
  org.opencontainers.image.licenses="MIT" \
  org.opencontainers.image.created="${BUILD_DATE}" \
  org.opencontainers.image.revision="${BUILD_REF}" \
  org.opencontainers.image.version="${BUILD_VERSION}"
