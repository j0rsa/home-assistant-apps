ARG UPSTREAM_IMAGE=ghcr.io/berriai/litellm:v1.93.0
ARG BUILD_FROM=ghcr.io/hassio-addons/ubuntu-base/amd64:11.0.0

FROM ${UPSTREAM_IMAGE} AS upstream

# Bundle all runtime artifacts; resolves the versioned Python lib path dynamically
# to avoid hardcoding the Python version (Wolfi installs packages to /usr/lib/python3.x/).
# LiteLLM itself lives in a uv virtualenv under /app (/app/.venv/bin/litellm, with the
# source on /app/litellm), so copying /app brings the CLI and its deps along. We also
# sweep /usr/bin for any python console_scripts by shebang. run.sh adds /app/.venv/bin
# to PATH so the `litellm` entrypoint resolves at runtime.
RUN PY_VER=$(python3 -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')") && \
    { \
      echo /usr/local; \
      echo /usr/bin/python3; \
      echo /usr/bin/python${PY_VER}; \
      echo /usr/lib/python${PY_VER}; \
      echo /usr/lib/libpython${PY_VER}.so.1.0; \
      echo /usr/lib/libcrypto.so.3; \
      echo /usr/lib/libssl.so.3; \
      echo /usr/lib/libgcc_s.so.1; \
      echo /app; \
      echo /root/.cache/prisma-python; \
      echo /root/.cache/prisma; \
      find /usr/bin -maxdepth 1 -type f \
        -exec sh -c 'head -c 50 "$1" | grep -qF "python" && echo "$1"' _ {} \;; \
    } | sort -u | tar -cf /upstream-payload.tar -T -

FROM ${BUILD_FROM}

ARG BUILD_VERSION
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF

# Install system runtime dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        jq \
        libssl3 \
        libffi8 \
        libsndfile1 \
        libatomic1 \
        nodejs \
        tzdata \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Extract Python, Node.js, and litellm from upstream image.
# Keep the upstream's OpenSSL 3.6 (that Python was compiled against) in a private
# directory instead of overwriting Ubuntu's system OpenSSL. Overwriting the system
# libssl.so.3/libcrypto.so.3 breaks the base image's curl, which bashio/s6 use to
# query the Supervisor API at boot (see run.sh for the LD_LIBRARY_PATH hand-off).
COPY --from=upstream /upstream-payload.tar /tmp/
RUN mkdir -p /opt/litellm/lib && \
    tar xf /tmp/upstream-payload.tar -C / && \
    mv -f /usr/lib/libcrypto.so.3 /usr/lib/libssl.so.3 /usr/lib/libgcc_s.so.1 /opt/litellm/lib/ && \
    ldconfig && \
    rm /tmp/upstream-payload.tar

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
