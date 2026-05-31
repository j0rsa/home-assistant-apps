# Changelog

## 1.83.14-4

- Actually fix the `aarch64` arch mismatch from `1.83.14-3`. Pinning the upstream stage with `linux/${BUILD_ARCH}` did not work (the `aarch64` arch string isn't the canonical `arm64`, so the build still pulled amd64 Python). Verified against the published `aarch64` image: base binaries were `arm64` but the bundled Python/OpenSSL were `amd64`. Now uses `FROM --platform=${TARGETPLATFORM}`, the canonical platform buildx derives from the HA builder's `--platform linux/arm64`.

## 1.83.14-3

- Fix `aarch64` builds crashing with `import: command not found` / shell syntax errors. The upstream stage is now pinned with `FROM --platform=linux/${BUILD_ARCH}`, so the bundled Python matches the target architecture instead of defaulting to the build host's `amd64` (which the kernel can't exec, causing the `#!python` shebang to fall back to `/bin/sh`).

## 1.83.14-2

- Fix container exiting with `exec: litellm: not found`. Upstream now ships the CLI in a uv virtualenv (`/app/.venv/bin/litellm`); `run.sh` puts `/app/.venv/bin` on `PATH` so the entrypoint resolves. The binary and its deps were already bundled via `/app`.

## 1.83.14-1

- Fix container failing to start (`FATAL: Unknown log_level:`). The build no longer overwrites the base image's system OpenSSL, which had broken the `curl` that bashio/s6 use to reach the Supervisor API at boot. The upstream OpenSSL 3.6 is now isolated to the LiteLLM process via `LD_LIBRARY_PATH`.

## 1.81.12-1

- Add `store_model_in_db` boolean option to persist model definitions in the database

## 1.0.0

- Initial release with LiteLLM proxy server
- OpenAI-compatible API endpoint on port 4000
- Web UI at `/ui` for model management and cost tracking
- PostgreSQL database support for persistent key and budget tracking
- User-defined model configuration via `/config/litellm_config.yaml`
