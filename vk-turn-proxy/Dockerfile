ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base-ubuntu:24.04
ARG UPSTREAM_IMAGE=ghcr.io/cacggghp/vk-turn-proxy:v1.8.2

FROM ${UPSTREAM_IMAGE} AS upstream
FROM ${BUILD_FROM}

ARG BUILD_VERSION
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates tzdata \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /app
COPY --from=upstream /app/vk-turn-proxy /app/vk-turn-proxy
COPY --from=upstream /app/docker-entrypoint.sh /app/docker-entrypoint.sh
COPY run.sh /run.sh
RUN chmod +x /app/docker-entrypoint.sh /app/vk-turn-proxy /run.sh

EXPOSE 56000/udp

CMD ["/run.sh"]

LABEL \
  io.hass.version=${BUILD_VERSION} \
  io.hass.type="addon" \
  io.hass.arch="${BUILD_ARCH}" \
  org.opencontainers.image.licenses="MIT" \
  org.opencontainers.image.created=${BUILD_DATE} \
  org.opencontainers.image.revision=${BUILD_REF} \
  org.opencontainers.image.version=${BUILD_VERSION}
