# Changelog

## 0.32.11

- Update upstream from `0.32.9` to `0.32.11` ([compare](https://github.com/ollama/ollama/compare/v0.32.9...v0.32.11))
## 0.32.9

- Update upstream from `0.32.6` to `0.32.9` ([compare](https://github.com/ollama/ollama/compare/v0.32.6...v0.32.9))
- Upstream v0.32.7 ([notes](https://github.com/ollama/ollama/releases/tag/v0.32.7))
- Upstream v0.32.8 ([notes](https://github.com/ollama/ollama/releases/tag/v0.32.8))
- Add Muse Glimmer support for NVIDIA, AMD, and additional platforms
- Upstream v0.32.9 ([notes](https://github.com/ollama/ollama/releases/tag/v0.32.9))
- Added the Nemotron 3 architecture
- Handle boundary condition in Muse Glimmer function calling parser
## 0.32.6-2

- Rebuild images after codenotary/`app_config` migration so CI publishes updated manifests

## 0.32.6-1

- Remove deprecated `codenotary` field from config and build metadata

## 0.32.6

- Update upstream from `0.32.5` to `0.32.6` ([compare](https://github.com/ollama/ollama/compare/v0.32.5...v0.32.6))
- Upstream v0.32.6 ([notes](https://github.com/ollama/ollama/releases/tag/v0.32.6))
- Qwen3.5 is faster on Apple GPUs: the MLX engine now uses the model's MTP head for speculative decoding automatically
- `/v1/chat/completions` streaming now matches OpenAI's wire format: `role` only on the first chunk, `finish_reason` on its own chunk
- Truncated OpenAI responses now report `finish_reason: "length"` instead of `"tool_calls"`.
- `ollama run kimi-k3` now offers `kimi-k3:cloud` for cloud-only models that publish no default tag, instead of failing.
- TUI fixes: pipe-delimited prose no longer renders as a table, Enter accepts the highlighted `@` file completion, and `/prompt`
- Experimental image generation has been temporarily removed. Continue using 0.32.5 for image generation support
- Updated the MLX and llama.cpp engines.
