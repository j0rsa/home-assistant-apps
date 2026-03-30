ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base:3.23

# Extract netmaker binary from upstream image
FROM gravitl/netmaker:v1.5.0 AS upstream

FROM ${BUILD_FROM}

RUN apk add --no-cache curl

COPY --from=upstream /root/netmaker /usr/local/bin/netmaker
RUN chmod +x /usr/local/bin/netmaker

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
