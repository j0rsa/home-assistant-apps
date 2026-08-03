ARG BUILD_FROM=ghcr.io/home-assistant/base:3.24

FROM ${BUILD_FROM}

ARG BUILD_VERSION
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF

RUN echo "**** Building $BUILD_ARCH:$BUILD_VERSION image ****" && \
    echo "**** install packages ****" && \
    apk add --no-cache \
      curl \
      jq \
      iproute2 \
      wireguard-tools && \
    echo "**** install netclient ****" && \
    if [ "$BUILD_ARCH" = "amd64" ]; then \
      NETCLIENT_ARCH="amd64"; \
    elif [ "$BUILD_ARCH" = "aarch64" ]; then \
      NETCLIENT_ARCH="arm64"; \
    else \
      echo "Unsupported arch '$BUILD_ARCH'" && \
      exit 255; \
    fi && \
    curl -fSL --retry 3 --retry-delay 2 \
      "https://github.com/gravitl/netclient/releases/download/v1.6.0/netclient-linux-${NETCLIENT_ARCH}" \
      -o /usr/local/bin/netclient || { echo "Failed to download netclient for ${NETCLIENT_ARCH}"; exit 1; } && \
    if [ ! -s /usr/local/bin/netclient ]; then \
      echo "Downloaded netclient is empty"; \
      exit 1; \
    fi && \
    if [ "$(head -c 4 /usr/local/bin/netclient)" != "$(printf '\177ELF')" ]; then \
      echo "Downloaded netclient is not an ELF binary (bad URL or HTML error page)"; \
      head -c 200 /usr/local/bin/netclient; \
      echo; \
      exit 1; \
    fi && \
    chmod +x /usr/local/bin/netclient && \
    /usr/local/bin/netclient version && \
    echo "**** setup directories ****" && \
    mkdir -p /dev/net /var/lib/netclient && \
    echo "**** cleanup ****" && \
    rm -rf /tmp/* /var/cache/apk/*

COPY run.sh /
RUN chmod a+x /run.sh

CMD ["/run.sh"]

LABEL \
  io.hass.version=${BUILD_VERSION} \
  io.hass.type="addon" \
  io.hass.arch="${BUILD_ARCH}" \
  org.opencontainers.image.licenses="MIT" \
  org.opencontainers.image.created=${BUILD_DATE} \
  org.opencontainers.image.revision=${BUILD_REF} \
  org.opencontainers.image.version=${BUILD_VERSION}
