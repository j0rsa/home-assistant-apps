# Changelog

## 0.1.16

- Add hailo_socket option to use hailortd multiplexer (set to /share/hailo/hailo_rt_service.sock when Hailo Daemon add-on is running)
- Add translations/en.yaml with descriptions for all configuration options

## 0.1.15

- Fix app disappearing from HA: replace invalid `privileged: true` with `full_access: true` (correct bool field per HA docs)
- Remove redundant `devices` entry (full_access covers all devices)

## 0.1.14

- Add privileged: true to config.yaml to allow full device access from the container
- Detect hailortd socket and set HAILO_MONITOR_SOCKET_PATH so the library uses daemon mode when the daemon holds the device

## 0.1.13

- Detect HailoRT driver/library version mismatch at startup and exit with a clear error instead of a cryptic traceback

## 0.1.12

- Fix model download failing with "mkdir: cannot create directory hefs: File exists" — symlinks were created before download, download script now writes directly to MODELS_DIR
- Symlinks are created after download completes

## 0.1.11

- Auto-install HailoRT .deb from hailo_packages/ if libhailort.so is missing in the container
- Update instructions to place both .deb and .whl into hailo_packages/

## 0.1.10

- Fix download_resources.sh: mkdir -P (invalid flag) caused decoder_assets/tiny directories to not be created
- Add early check for libhailort.so with instructions to install the HailoRT Debian package

## 0.1.9

- Detect Python version at runtime and validate wheel compatibility before install
- Show correct cp-tag in error message (e.g. cp311) so the right wheel is downloaded

## 0.1.8

- Improve missing Hailo wheel error with step-by-step download instructions

## 0.1.7

- Switch base image from Alpine (hassio-addons/base-python) to Debian bookworm to support PyTorch aarch64 wheels

## 0.1.6

- Fix musl exact-version pin in /etc/apk/world that blocked apk upgrade from updating musl

## 0.1.5

- Fix musl version conflict: run full apk upgrade before apk add (base image 13.1.3 has stale pinned packages)

## 0.1.4

- Fix musl version conflict by upgrading musl before installing musl-dev (Alpine 3.19 repo drift)

## 0.1.3

- Revert build.yaml base image to 13.1.3 (18.0.0 causes musl version conflict); restore py3-pip/setuptools/wheel for Alpine 3.19

## 0.1.2

- Fix apk packages py3-pip/py3-setuptools/py3-wheel no longer available in Alpine 3.21 (base-python 18.0.0 already bundles them)

## 0.1.1

- Fix build failure caused by COPY of missing hailo_packages/ directory (wheels are user-supplied at runtime)
- Fix base image version mismatch between build.yaml and Dockerfile (align to 18.0.0)
