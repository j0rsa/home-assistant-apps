ARG UPSTREAM_IMAGE=ainullcode/borg-ui:edge
ARG BUILD_FROM=ghcr.io/home-assistant/base-ubuntu:26.04

FROM ${UPSTREAM_IMAGE} AS upstream

FROM ${BUILD_FROM}

ARG BUILD_VERSION
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF

# Runtime deps matching upstream's python:3.12-slim (Debian bookworm) base.
# No Python from Ubuntu's repos — we copy the full CPython runtime from upstream.
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        cron \
        curl \
        fuse3 \
        gosu \
        libacl1 \
        libfuse3-dev \
        liblz4-1 \
        libssl3 \
        libxxhash0 \
        libzstd1 \
        openssh-client \
        rsync \
        sshfs \
        sshpass \
        sudo \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy Python 3.12 interpreter, stdlib, and all site-packages from upstream
COPY --from=upstream /usr/local/bin /usr/local/bin
COPY --from=upstream /usr/local/lib/python3.12 /usr/local/lib/python3.12
COPY --from=upstream /usr/local/lib/libpython3.12.so.1.0 /usr/local/lib/libpython3.12.so.1.0
COPY --from=upstream /usr/local/lib/libpython3.12.so /usr/local/lib/libpython3.12.so
COPY --from=upstream /usr/local/lib/libpython3.so /usr/local/lib/libpython3.so

# Copy borg2 venv and rclone
COPY --from=upstream /opt/borg2-venv /opt/borg2-venv
COPY --from=upstream /usr/bin/rclone /usr/bin/rclone

# Copy application and agent wheelhouse
COPY --from=upstream /app /app
COPY --from=upstream /opt/borg-ui /opt/borg-ui
COPY --from=upstream /entrypoint.sh /entrypoint.sh

# Register the shared Python library and set up borg user, groups, directories
RUN ldconfig && \
    mkdir -p \
        /data /data/ssh_keys /data/borg_keys /data/logs /data/config \
        /backups /var/log/borg /etc/borg \
        /home/borg/.ssh /home/borg/.cache/borg /etc/cron.d && \
    groupadd -g 1001 borg && \
    useradd -m -u 1001 -g 1001 -s /bin/bash borg && \
    usermod -a -G sudo borg && \
    groupadd -f fuse && \
    usermod -a -G fuse borg && \
    echo "borg ALL=(ALL) NOPASSWD: /usr/bin/borg, /usr/bin/crontab, /usr/bin/apt-get" >> /etc/sudoers && \
    sed -i 's/^#user_allow_other/user_allow_other/' /etc/fuse.conf && \
    chown -R borg:borg /app /data /backups /var/log/borg /etc/borg /home/borg && \
    chmod -R 755 /app /data /backups /var/log/borg /etc/borg && \
    chmod 700 /home/borg/.ssh /home/borg/.cache/borg && \
    python3 -c "from cryptography.fernet import Fernet"

ENV PYTHONPATH=/app
ENV DATA_DIR=/data
ENV BORG_BACKUP_PATH=/backups
ENV BORG_CACHE_DIR=/home/borg/.cache/borg
ENV PORT=8081
ENV OPENSSL_armcap=0

COPY run.sh /run-ha.sh
RUN chmod a+x /run-ha.sh

ENTRYPOINT ["/run-ha.sh"]

LABEL \
  io.hass.version=${BUILD_VERSION} \
  io.hass.type="addon" \
  io.hass.arch="${BUILD_ARCH}" \
  org.opencontainers.image.licenses="MIT" \
  org.opencontainers.image.created=${BUILD_DATE} \
  org.opencontainers.image.revision=${BUILD_REF} \
  org.opencontainers.image.version=${BUILD_VERSION}
