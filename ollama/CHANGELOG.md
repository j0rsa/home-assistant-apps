# Changelog

## 0.40.12

- Update upstream from `0.40.11` to `0.40.12` ([compare](https://github.com/ollama/ollama/compare/v0.40.11...v0.40.12))
- Upstream v0.40.12 ([notes](https://github.com/ollama/ollama/releases/tag/v0.40.12))
- [lfm3](https://ollama.com/library/lfm3): a 1.7B text model with a 256K-token context window
- [lfm3-vl](https://ollama.com/library/lfm3-vl): adds image understanding
- [lfm3-audio](https://ollama.com/library/lfm3-audio): speech recognition, translation, and text-to-speech in 18 languages
- [lfm3-omni](https://ollama.com/library/lfm3-omni): text, images, and audio in one model
- Faster prompt processing on Apple silicon for Gemma 4, Flint and Laguna models
- Speculative decoding now supports DFlash2 draft models on MLX
- Gemma 4 keeps more detail in small images
- `ollama launch` now works with OpenCode v2
- Fixed tool-only assistant turns from Kimi CLI
- Updated MLX and llama.cpp
## 0.40.11

- Update upstream from `0.40.10` to `0.40.11` ([compare](https://github.com/ollama/ollama/compare/v0.40.10...v0.40.11))
- Upstream v0.40.11 ([notes](https://github.com/ollama/ollama/releases/tag/v0.40.11))
- @SynapShift made their first contribution in https://github.com/ollama/ollama/pull/19173
## 0.40.10

- Update upstream from `0.40.8` to `0.40.10` ([compare](https://github.com/ollama/ollama/compare/v0.40.8...v0.40.10))
- Upstream v0.40.9 ([notes](https://github.com/ollama/ollama/releases/tag/v0.40.9))
- Streaming OpenAI Responses and Anthropic Messages requests now report generation failures instead of ending silently after partial output.
- `ollama launch` now passes cloud models' context lengths and capabilities to coding tools, fixing incorrect context and compaction settings.
- Anthropic-compatible web search now uses the model's supported thinking setting in follow-up requests, preventing avoidable failures.
- Upstream v0.40.10 ([notes](https://github.com/ollama/ollama/releases/tag/v0.40.10))
## 0.40.8

- Update upstream from `0.40.6` to `0.40.8` ([compare](https://github.com/ollama/ollama/compare/v0.40.6...v0.40.8))
- Upstream v0.40.7 ([notes](https://github.com/ollama/ollama/releases/tag/v0.40.7))
- [pplx-decider](https://ollama.com/library/pplx-decider) is a 27B decision model from Perplexity, fine-tuned from
- Continuing an OpenAI-compatible Responses conversation no longer fails when switching between models with and without
- Fixed streaming Responses requests where client tool calls (e.g. Codex with web search) could emit before open
- Requests routed to remote models are now cancelled on ollama.com when the client disconnects, instead of continuing
- `ollama show` now reports which renderer and parser a model uses and where its chat template comes from; the API
- More draft models now work with speculative decoding: llama-server infers the draft type automatically instead of
- `ollama launch claude` now clamps `CLAUDE_CODE_AUTO_COMPACT_WINDOW` to Claude Code's supported range, avoiding a
- Updated llama.cpp and MLX
- Upstream v0.40.8 ([notes](https://github.com/ollama/ollama/releases/tag/v0.40.8))
## 0.40.6

- Update upstream from `0.40.5` to `0.40.6` ([compare](https://github.com/ollama/ollama/compare/v0.40.5...v0.40.6))
- Upstream v0.40.6 ([notes](https://github.com/ollama/ollama/releases/tag/v0.40.6))
- win: prevent orphaned runners by @dhiltgen in https://github.com/ollama/ollama/pull/18500
- gguf: add the q2_0 tensor and file types by @jmorganca in https://github.com/ollama/ollama/pull/18967
- Launch clef in Ollama's cloud by @jberg5 in https://github.com/ollama/ollama/pull/19036
- use identifiers for --ask mode question keys by @jberg5 in https://github.com/ollama/ollama/pull/19041
## 0.40.5

- Update upstream from `0.40.4` to `0.40.5` ([compare](https://github.com/ollama/ollama/compare/v0.40.4...v0.40.5))
- Upstream v0.40.5 ([notes](https://github.com/ollama/ollama/releases/tag/v0.40.5))
- Decision models are now available on cloud — use `clef:cloud` and `clef-flash:cloud` to run decision models through ollama.com cloud without pulling them locally
- Continuing an OpenAI-compatible Responses conversation that includes custom tool calls no longer fails with an error
- Clearer error messages when cloud access fails: sign-in problems, payment issues in the desktop app, and upstream access errors from the ChatGPT gateway now explain what went wrong
- Updated llama.cpp (adding Nemotron 3.5 support) and MLX
- @willietran made their first contribution in https://github.com/ollama/ollama/pull/18986
## 0.40.4

- Update upstream from `0.40.3` to `0.40.4` ([compare](https://github.com/ollama/ollama/compare/v0.40.3...v0.40.4))
- Upstream v0.40.4 ([notes](https://github.com/ollama/ollama/releases/tag/v0.40.4))
- llama: update llama.cpp to b11521 for decision models and EmbeddingGemma 2 by @jmorganca in https://github.com/ollama/ollama/pull/18917
- server: reuse verified manifests and loaded models in inference routes by @dhiltgen in https://github.com/ollama/ollama/pull/18947
- mlx: compact restored recurrent state after speculative rollback by @dhiltgen in https://github.com/ollama/ollama/pull/18955
- launch: include installed models in Codex /model picker by @ParthSareen in https://github.com/ollama/ollama/pull/18887
- MLX, MLX-C: version bump by @dhiltgen in https://github.com/ollama/ollama/pull/18956
## 0.40.3

- Update upstream from `0.40.2` to `0.40.3` ([compare](https://github.com/ollama/ollama/compare/v0.40.2...v0.40.3))
- Upstream v0.40.3 ([notes](https://github.com/ollama/ollama/releases/tag/v0.40.3))
- `ollama launch claude` no longer shows a warning about Claude connectors by @hoyyeva in https://github.com/ollama/ollama/pull/18878
- `ollama launch codex` no longer warns about service tiers by @hoyyeva in https://github.com/ollama/ollama/pull/18879
- Paused background model upgrade for embedding and other request performance, by @jmorganca in https://github.com/ollama/ollama/pull/18908
## 0.40.2

- Update upstream from `0.40.1` to `0.40.2` ([compare](https://github.com/ollama/ollama/compare/v0.40.1...v0.40.2))
- Upstream v0.40.2 ([notes](https://github.com/ollama/ollama/releases/tag/v0.40.2))
- README: add oxi to community integrations by @maziluiosif in https://github.com/ollama/ollama/pull/18739
- server: hide duplicate and downgrade guards from list by @dhiltgen in https://github.com/ollama/ollama/pull/18874
- @maziluiosif made their first contribution in https://github.com/ollama/ollama/pull/18739
## 0.40.1

- Update upstream from `0.40.0` to `0.40.1` ([compare](https://github.com/ollama/ollama/compare/v0.40.0...v0.40.1))
## 0.40.0

- Update upstream from `0.35.1` to `0.40.0` ([compare](https://github.com/ollama/ollama/compare/v0.35.1...v0.40.0))
- Upstream v0.40.0 ([notes](https://github.com/ollama/ollama/releases/tag/v0.40.0))
## 0.35.1

- Update upstream from `0.35.0` to `0.35.1` ([compare](https://github.com/ollama/ollama/compare/v0.35.0...v0.35.1))
- Upstream v0.35.1 ([notes](https://github.com/ollama/ollama/releases/tag/v0.35.1))
- Models using web search can now perform up to ten searches per response, up from three
- Modelfiles now support `CAPABILITY` declarations, so model creators can explicitly declare what a model can do. Declarations are preserved when creating from GGUF or safetensors, through model inheritance, and on Modelfile export
- `ollama show` and the model list now report only `decision` as the capability for decision models, so clients no longer offer them for general chat, tools, or thinking
- Updated llama.cpp and the MLX engine
## 0.35.0

- Update upstream from `0.34.4` to `0.35.0` ([compare](https://github.com/ollama/ollama/compare/v0.34.4...v0.35.0))
- Upstream v0.35.0 ([notes](https://github.com/ollama/ollama/releases/tag/v0.35.0))
- [**Nimble**](https://ollama.com/library/nimble) from Bespoke Labs
- [**Tev1**](https://ollama.com/library/tev1) from Together AI
- `choice`: Select an option and return probabilities for each.
- `noul`: Return the probability that a condition is true.
- `score`: Return a score across an ordered set of criteria
- Settings now opens without waiting for model discovery.
- Fixed the macOS update menu and icon not reflecting an available update at startup.
- Fixed stalled MLX model downloads hanging indefinitely.
- Requests containing the deprecated `typical_p` parameter now log a warning instead of failing.
## 0.34.4

- Update upstream from `0.34.3` to `0.34.4` ([compare](https://github.com/ollama/ollama/compare/v0.34.3...v0.34.4))
- Upstream v0.34.4 ([notes](https://github.com/ollama/ollama/releases/tag/v0.34.4))
- Structured outputs on thinking models now apply in a single pass, making them faster and more reliable.
- Fixed intermittent "model not found" errors with a large local library
- Fixed the macOS app becoming unresponsive when checking if ChatGPT or Codex is running.
- Qwen 3.8 prompt processing is faster on Apple Silicon.
- Gemma 4 on Apple Silicon now picks the best image resolution per image, keeping more detail in high-resolution images.
- Updated llama.cpp, MLX, and XGrammar.
## 0.34.3

- Update upstream from `0.34.2` to `0.34.3` ([compare](https://github.com/ollama/ollama/compare/v0.34.2...v0.34.3))
- Upstream v0.34.3 ([notes](https://github.com/ollama/ollama/releases/tag/v0.34.3))
- Nemotron H** vision models are now supported on Apple Silicon with MLX
- Ollama's macOS app will now no longer reopen windows you've closed when activating it
- Fix for model pulls from HuggingFace
## 0.34.2

- Update upstream from `0.34.1` to `0.34.2` ([compare](https://github.com/ollama/ollama/compare/v0.34.1...v0.34.2))
- Upstream v0.34.2 ([notes](https://github.com/ollama/ollama/releases/tag/v0.34.2))
- Added first-run setup when running `ollama`, with options to sign in or continue locally. Setup completion is shared with the desktop app on macOS and Windows.
- Added `ollama://apps` to open the desktop app’s Apps page directly on macOS and Windows.
- Fixed excessive memory growth during long generations with MLX speculative decoding.
- Updated llama.cpp.
## 0.34.1

- Update upstream from `0.34.0` to `0.34.1` ([compare](https://github.com/ollama/ollama/compare/v0.34.0...v0.34.1))
- Upstream v0.34.1 ([notes](https://github.com/ollama/ollama/releases/tag/v0.34.1))
- MLX safetensors `ollama create` no longer experimental. GGUF model creation now requires using llama.cpp tooling for safetensor conversion and quantization.
- Improved MLX memory handling on Apple Silicon
- Runaway repeat token detection now requires 100 repeat tokens for reduced false positives (e.g. OCR)
- `/api/tags` is much faster on large model libraries (3.1 s → 294 ms cold in testing), and model capabilities are now reported consistently.
- Deprecated `typical_p`: it can no longer be set when creating new models, existing GGUF models retain support.
- MLX and llama.cpp updates
## 0.34.0

- Update upstream from `0.33.3` to `0.34.0` ([compare](https://github.com/ollama/ollama/compare/v0.33.3...v0.34.0))
- Upstream v0.34.0 ([notes](https://github.com/ollama/ollama/releases/tag/v0.34.0))
## 0.33.3

- Update upstream from `0.33.2` to `0.33.3` ([compare](https://github.com/ollama/ollama/compare/v0.33.2...v0.33.3))
- Upstream v0.33.3 ([notes](https://github.com/ollama/ollama/releases/tag/v0.33.3))
- gemma4 now supports images and audio on MLX engine
- Report cached prompt tokens
- Honor GGUF model defined default parameters
- MLX, MLX-C, llama.cpp update
- @marcelpetrick made their first contribution in https://github.com/ollama/ollama/pull/17579
## 0.33.2

- Update upstream from `0.33.1` to `0.33.2` ([compare](https://github.com/ollama/ollama/compare/v0.33.1...v0.33.2))
- Upstream v0.33.2 ([notes](https://github.com/ollama/ollama/releases/tag/v0.33.2))
- Ollama's app now follows the system appearance again, restoring dark mode support
- Fixed the macOS app to properly hand off to an already-running instance instead of starting a second one
- The Claude Desktop proxy no longer interrupts in-flight requests when the model catalog updates
## 0.33.1

- Update upstream from `0.33.0` to `0.33.1` ([compare](https://github.com/ollama/ollama/compare/v0.33.0...v0.33.1))
- Upstream v0.33.1 ([notes](https://github.com/ollama/ollama/releases/tag/v0.33.1))
- MLX: Qwen3.8 Flash Next support
- cmake: make external compat patches idempotent
- MLX and llama.cpp update
- mlxrunner: add structured output support
- mlxrunner: avoid Metal GPU timeouts when loading models from slow storage
- @pd95 made their first contribution in https://github.com/ollama/ollama/pull/17948
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
