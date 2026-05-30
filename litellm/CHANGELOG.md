# Changelog

## 1.83.10-1

- Fix container failing to start (`FATAL: Unknown log_level:`). The build no longer overwrites the base image's system OpenSSL, which had broken the `curl` that bashio/s6 use to reach the Supervisor API at boot. The upstream OpenSSL 3.6 is now isolated to the LiteLLM process via `LD_LIBRARY_PATH`.

## 1.81.12-1

- Add `store_model_in_db` boolean option to persist model definitions in the database

## 1.0.0

- Initial release with LiteLLM proxy server
- OpenAI-compatible API endpoint on port 4000
- Web UI at `/ui` for model management and cost tracking
- PostgreSQL database support for persistent key and budget tracking
- User-defined model configuration via `/config/litellm_config.yaml`
