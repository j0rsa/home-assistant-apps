ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base:3.23

# Extract UI files and nginx config from upstream image
FROM gravitl/netmaker-ui:v0.99.0 AS upstream

FROM ${BUILD_FROM}

RUN apk add --no-cache nginx

COPY --from=upstream /usr/share/nginx/html /usr/share/nginx/html
COPY --from=upstream /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf

COPY run.sh /
RUN chmod a+x /run.sh

CMD ["/run.sh"]

ARG BUILD_VERSION
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF

LABEL \
  io.hass.version=${BUILD_VERSION} \
  io.hass.type="addon" \
  io.hass.arch="${BUILD_ARCH}" \
  org.opencontainers.image.licenses="MIT" \
  org.opencontainers.image.created=${BUILD_DATE} \
  org.opencontainers.image.revision=${BUILD_REF} \
  org.opencontainers.image.version=${BUILD_VERSION}
