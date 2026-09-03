ARG UPSTREAM_IMAGE=ghcr.io/berriai/litellm:v1.99.1
ARG BUILD_FROM=ghcr.io/home-assistant/base-ubuntu:26.04

FROM ${UPSTREAM_IMAGE} AS upstream

# Bundle all runtime artifacts; resolves the versioned Python lib path dynamically
# to avoid hardcoding the Python version (Wolfi installs packages to /usr/lib/python3.x/).
# LiteLLM itself lives in a uv virtualenv under /app (/app/.venv/bin/litellm, with the
# source on /app/litellm), so copying /app brings the CLI and its deps along. We also
# sweep /usr/bin for any python console_scripts by shebang. run.sh adds /app/.venv/bin
# to PATH so the `litellm` entrypoint resolves at runtime.
# Prisma CLI + engines are baked at /opt/prisma (since upstream v1.93.0); older
# /root/.cache/prisma* paths are gone. run.sh pins PRISMA_* so migrations stay offline.
# Do not ship upstream (Wolfi) libssl/libcrypto. Ubuntu 26.04 provides OpenSSL
# 3.5.x which is ABI-compatible with the bundled Python (_ssl links libssl.so.3).
# Putting Wolfi OpenSSL 3.6 on LD_LIBRARY_PATH breaks the base openssl CLI
# (undefined symbol BIO_f_zlib) and cascades into Prisma "Not connected".
#
# Stage Wolfi glibc under /opt/litellm/lib (not /lib). Ubuntu 26.04 ships glibc
# 2.43; Wolfi CPython 3.13 needs GLIBC_2.44. Overwriting Ubuntu's dynamic linker
# would break bashio/s6. wrap-wolfi-python patchelf's CPython in place so the
# private loader is used without replacing the venv python (argv[0] must stay
# under /app/.venv or site-packages is dropped).
RUN mkdir -p /opt/litellm/lib && \
    found_ld=0 && \
    for dir in /lib /usr/lib /lib64 /usr/lib64; do \
        [ -d "${dir}" ] || continue; \
        for f in \
            "${dir}"/ld-linux*.so* \
            "${dir}"/libc.so* \
            "${dir}"/libm.so* \
            "${dir}"/libmvec.so* \
            "${dir}"/libgcc_s.so* \
            "${dir}"/libpthread.so* \
            "${dir}"/libdl.so* \
            "${dir}"/librt.so* \
            "${dir}"/libresolv.so* \
            "${dir}"/libutil.so* \
            "${dir}"/libcrypt.so* \
            "${dir}"/libanl.so* \
            "${dir}"/libnss_*.so*; do \
            [ -e "${f}" ] || continue; \
            cp -aL "${f}" /opt/litellm/lib/; \
            case "${f}" in \
                */ld-linux*.so*) found_ld=1 ;; \
            esac; \
        done; \
    done && \
    [ "${found_ld}" = 1 ] && \
    test -e /opt/litellm/lib/libc.so.6 && \
    test -e /opt/litellm/lib/libm.so.6

RUN PY_VER=$(python3 -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')") && \
    { \
      echo /usr/local; \
      echo /usr/bin/python3; \
      echo /usr/bin/python${PY_VER}; \
      echo /usr/lib/python${PY_VER}; \
      echo /usr/lib/libpython${PY_VER}.so.1.0; \
      echo /app; \
      echo /opt/prisma; \
      echo /opt/litellm/lib; \
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
        npm \
        tzdata \
        patchelf \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Extract Python and litellm from upstream; use Ubuntu's system OpenSSL.
# patchelf CPython onto the private Wolfi loader without moving the binary.
COPY --from=upstream /upstream-payload.tar /tmp/
COPY wrap-wolfi-python /usr/local/bin/wrap-wolfi-python
RUN chmod a+x /usr/local/bin/wrap-wolfi-python && \
    tar xf /tmp/upstream-payload.tar -C / && \
    chmod -R a+rX /opt/prisma /opt/litellm && \
    wrap-wolfi-python && \
    ldconfig && \
    rm /tmp/upstream-payload.tar && \
    python3 -c "from math import log" && \
    /app/.venv/bin/python3 -c "from math import log; from litellm import run_server"

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
