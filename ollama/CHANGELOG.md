# Changelog

## 0.33.0

- Update upstream from `0.32.15` to `0.33.0` ([compare](https://github.com/ollama/ollama/compare/v0.32.15...v0.33.0))
- Upstream v0.33.0 ([notes](https://github.com/ollama/ollama/releases/tag/v0.33.0))
- Turn individual Ollama models on or off for use in Claude, directly from the menu bar
- Choose from your available Ollama models from within Claude; cloud models appear only when you're signed in
- A new **Apps** view manages app integrations with copyable commands
- Fixed a hang where agent clients that cancel long prefills
- Prefill restore points are now trustworthy by construction: a cancelled prefill keeps every restore point it crossed, so retries resume where they stopped instead of restarting from scratch
- Resumed prefills no longer record restore points that fail to cover what they claim; on models with recurrent layers this previously forced a request matching 46k of 47k tokens to reprocess from zero
- Disabled Claude Code's "tokens left" token-countdown system message, which Ollama moved to the front of the prompt and broke the KV cache on every request
- DeepSeek Harness launcher now falls back to `npx` when the global npm install fails, with Windows command-shim support
- Onboarding flow has clearer introductory copy, a macOS header aligned with the native traffic-light controls, and Cmd/Ctrl zoom shortcuts disabled during onboarding so the fixed window keeps its intended scale
- MLX dependency update (#17886)
- Fixed broken default packaging caused by macOS-specific assumptions affecting Linux/Windows builds
- Fixed the Apps header overlapping the macOS traffic lights during sidebar open transitions by synchronizing the header padding animation with the sidebar width animation
## 0.32.15

- Update upstream from `0.32.14` to `0.32.15` ([compare](https://github.com/ollama/ollama/compare/v0.32.14...v0.32.15))
- Upstream v0.32.15 ([notes](https://github.com/ollama/ollama/releases/tag/v0.32.15))
- Add a model metadata cache to reduce Ollama’s per-request overhead
- @gaugarg-nv made their first contribution in https://github.com/ollama/ollama/pull/17752
## 0.32.14

- Update upstream from `0.32.13` to `0.32.14` ([compare](https://github.com/ollama/ollama/compare/v0.32.13...v0.32.14))
- Upstream v0.32.14 ([notes](https://github.com/ollama/ollama/releases/tag/v0.32.14))
- llm: transcode WebP images for llama-server
- renderers/qwen: tolerate non-leading system messages
## 0.32.13

- Update upstream from `0.32.11` to `0.32.13` ([compare](https://github.com/ollama/ollama/compare/v0.32.11...v0.32.13))
- Upstream v0.32.12 ([notes](https://github.com/ollama/ollama/releases/tag/v0.32.12))
- Upstream v0.32.13 ([notes](https://github.com/ollama/ollama/releases/tag/v0.32.13))
- qwen3.8: support developer instructions
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
