ARG UPSTREAM_IMAGE=copyparty/ac:1.20.20
ARG BUILD_FROM=ghcr.io/home-assistant/base:3.24

FROM ${UPSTREAM_IMAGE} AS upstream

FROM ${BUILD_FROM}

ARG BUILD_VERSION
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF

# Alpine 3.24 matches upstream copyparty/ac; python3.14 + ffmpeg for thumbnails.
RUN apk add --no-cache \
        ca-certificates \
        ffmpeg \
        jq \
        libffi \
        python3 \
    && mkdir -p /cfg /cfg/hists

COPY --from=upstream /usr/lib/python3.14/site-packages /usr/lib/python3.14/site-packages

COPY run.sh /
RUN chmod a+x /run.sh

CMD ["/run.sh"]

LABEL \
  io.hass.version=${BUILD_VERSION} \
  io.hass.type="addon" \
  io.hass.arch="${BUILD_ARCH}" \
  org.opencontainers.image.licenses="MIT" \
  org.opencontainers.image.title="Copyparty Home Assistant app" \
  org.opencontainers.image.description="File server with web UI, uploads, and WebDAV" \
  org.opencontainers.image.created=${BUILD_DATE} \
  org.opencontainers.image.revision=${BUILD_REF} \
  org.opencontainers.image.version=${BUILD_VERSION}
