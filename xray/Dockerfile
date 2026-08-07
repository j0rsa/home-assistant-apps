ARG BUILD_FROM=ghcr.io/home-assistant/base-ubuntu:26.04

FROM ${BUILD_FROM}

ARG BUILD_VERSION
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
# Pin release so CI builds do not scrape GitHub's unauthenticated /releases/latest API.
ARG XRAY_VERSION=v26.3.27

RUN echo "**** Building $BUILD_ARCH:$BUILD_VERSION image ****" && \
    echo "**** install packages ****" && \
    apt-get update && \
    apt-get install -y \
      curl \
      unzip \
      ca-certificates \
      netcat-openbsd \
      jq && \
    echo "**** install xray-core ****" && \
    echo "Using Xray version: ${XRAY_VERSION}" && \
    if [ "$BUILD_ARCH" = "amd64" ]; then \
      XRAY_ARCH="linux-64"; \
    elif [ "$BUILD_ARCH" = "aarch64" ]; then \
      XRAY_ARCH="linux-arm64-v8a"; \
    elif [ "$BUILD_ARCH" = "armv7" ]; then \
      XRAY_ARCH="linux-arm32-v7a"; \
    else \
      echo "Unsupported arch '$BUILD_ARCH'" && \
      exit 255; \
    fi && \
    curl -fsSL "https://github.com/XTLS/Xray-core/releases/download/${XRAY_VERSION}/Xray-${XRAY_ARCH}.zip" -o /tmp/xray.zip && \
    unzip /tmp/xray.zip -d /usr/local/bin/ && \
    chmod +x /usr/local/bin/xray && \
    echo "**** cleanup ****" && \
    apt-get clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

COPY run.sh /
COPY debug.sh /usr/local/bin/xray-debug
RUN chmod a+x /run.sh && chmod a+x /usr/local/bin/xray-debug

CMD ["/run.sh"]

LABEL \
  io.hass.version=${BUILD_VERSION} \
  io.hass.type="addon" \
  io.hass.arch="${BUILD_ARCH}" \
  org.opencontainers.image.licenses="MIT" \
  org.opencontainers.image.created=${BUILD_DATE} \
  org.opencontainers.image.revision=${BUILD_REF} \
  org.opencontainers.image.version=${BUILD_VERSION}