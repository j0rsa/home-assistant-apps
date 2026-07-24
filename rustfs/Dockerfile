ARG UPSTREAM_IMAGE=rustfs/rustfs:1.0.0-beta.11-glibc
ARG BUILD_FROM=ghcr.io/home-assistant/base-ubuntu:26.04

FROM ${UPSTREAM_IMAGE} AS upstream

FROM ${BUILD_FROM}

ARG BUILD_VERSION
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF

# Runtime deps; jq for options, nginx for Home Assistant Ingress path rewriting.
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        jq \
        libgcc-s1 \
        nginx \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy RustFS binary + upstream entrypoint (credential checks / volume init).
COPY --from=upstream /usr/bin/rustfs /usr/bin/rustfs
COPY --from=upstream /entrypoint.sh /entrypoint.sh
RUN chmod a+x /usr/bin/rustfs /entrypoint.sh

COPY nginx.conf /etc/nginx/nginx.conf
COPY run.sh /
RUN chmod a+x /run.sh

CMD ["/run.sh"]

LABEL \
  io.hass.version=${BUILD_VERSION} \
  io.hass.type="addon" \
  io.hass.arch="${BUILD_ARCH}" \
  org.opencontainers.image.licenses="Apache-2.0" \
  org.opencontainers.image.title="RustFS Home Assistant app" \
  org.opencontainers.image.description="S3-compatible object storage powered by RustFS" \
  org.opencontainers.image.created=${BUILD_DATE} \
  org.opencontainers.image.revision=${BUILD_REF} \
  org.opencontainers.image.version=${BUILD_VERSION}
