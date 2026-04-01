ARG BUILD_FROM=ghcr.io/hassio-addons/base-python/aarch64:13.1.3
FROM ${BUILD_FROM}

ARG BUILD_VERSION
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    PYTHONUNBUFFERED=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    APP_DIR=/opt/wyoming-hailo-whisper \
    VENV_DIR=/opt/wyoming-hailo-whisper/.venv \
    PATH=/opt/wyoming-hailo-whisper/.venv/bin:${PATH}

WORKDIR ${APP_DIR}

COPY hailo_packages/ ./hailo_packages/
COPY script/ ./script/
COPY wyoming_hailo_whisper/ ./wyoming_hailo_whisper/
COPY requirements.txt setup.py setup.cfg docker-entrypoint.sh start-hailo-example.sh LICENSE.md ./
COPY run.sh /run.sh

RUN apk add --no-cache \
      bash \
      ffmpeg \
      g++ \
      gcc \
      git \
      linux-headers \
      make \
      musl-dev \
      portaudio \
      py3-pip \
      py3-setuptools \
      py3-wheel \
      python3 \
      python3-dev \
      wget \
    && python3 -m venv ${VENV_DIR} \
    && ${VENV_DIR}/bin/pip install --upgrade pip setuptools wheel \
    && ${VENV_DIR}/bin/pip install --no-cache-dir -r requirements.txt \
    && ${VENV_DIR}/bin/pip install --no-cache-dir . \
    && chmod +x /run.sh docker-entrypoint.sh start-hailo-example.sh script/* wyoming_hailo_whisper/app/download_resources.sh \
    && rm -rf /root/.cache /tmp/*

EXPOSE 10600

CMD ["/run.sh"]

LABEL \
  io.hass.version=${BUILD_VERSION} \
  io.hass.type="addon" \
  io.hass.arch="${BUILD_ARCH}" \
  org.opencontainers.image.licenses="MIT" \
  org.opencontainers.image.created=${BUILD_DATE} \
  org.opencontainers.image.revision=${BUILD_REF} \
  org.opencontainers.image.version=${BUILD_VERSION}
