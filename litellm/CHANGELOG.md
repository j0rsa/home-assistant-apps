# Changelog

## 1.96.0

- Update upstream from `v1.95.0` to `v1.96.0` ([compare](https://github.com/BerriAI/litellm/compare/v1.95.0...v1.96.0))
## 1.95.0-2

- Rebuild images after codenotary/`app_config` migration so CI publishes updated manifests

## 1.95.0-1

- Remove deprecated `codenotary` field from config and build metadata
- Replace legacy `addon_config` map type with `app_config`

## 1.95.0

- Update upstream from `v1.94.1` to `v1.95.0` ([compare](https://github.com/BerriAI/litellm/compare/v1.94.1...v1.95.0))
## 1.94.1

- Update upstream from `v1.93.0` to `v1.94.1` ([compare](https://github.com/BerriAI/litellm/compare/v1.93.0...v1.94.1))
- Upstream v1.94.0 ([notes](https://github.com/BerriAI/litellm/releases/tag/v1.94.0))
- feat(ui): working Test Connection for the complexity auto router by @akapur99 in https://github.com/BerriAI/litellm/pull/32950
- fix(xecguard): use StandardLoggingGuardrailInformation in logging hook by @yucheng-berri in https://github.com/BerriAI/litellm/pull/32911
- feat(ui): adopt openapi-react-query ($api) and convert useCustomers by @ryan-crabbe-berri in https://github.com/BerriAI/litellm/pull/32949
- refactor(ui): colocate the mcp-servers view, keeping the shared mcp_tools surface by @ryan-crabbe-berri in https://github.com/BerriAI/litellm/pull/32968
- refactor(ui): convert endpoint usage charts to shadcn/recharts by @ryan-crabbe-berri in https://github.com/BerriAI/litellm/pull/32723
- fix(proxy-auth): stop unrecognized model namespaces slipping through provider wildcard keys by @mateo-berri in https://github.com/BerriAI/litellm/pull/32979
- feat(router): random-pick multi-model complexity tiers by @krrish-berri-2 in https://github.com/BerriAI/litellm/pull/32967
- fix(xecguard): sanitize scan result before recording it for logging by @yucheng-berri in https://github.com/BerriAI/litellm/pull/32935
- fix(auto_router): filter embedding models in complexity tab dropdowns, require all tiers, inline validation by @akapur99 in https://github.com/BerriAI/litellm/pull/32978
- fix(anthropic): translate raw adaptive thinking for pre-4.6 models on chat completions and Bedrock Converse by @akapur99 in https://github.com/BerriAI/litellm/pull/32944
- feat(router): add Router(plugins=[...]) routing-plugin pipeline by @krrish-berri-2 in https://github.com/BerriAI/litellm/pull/32972
- feat(router): soft-floor adaptive mode for complexity router by @krrish-berri-2 in https://github.com/BerriAI/litellm/pull/32947
- docs(github): add QA runbook section to the PR template by @mateo-berri in https://github.com/BerriAI/litellm/pull/32965
- fix(model_cost): add supports_reasoning: false to Gemini image generation models by @mateo-berri in https://github.com/BerriAI/litellm/pull/32836
- build(dev-env): add make bootstrap and unprovisioned-checkout preflight to pre-commit by @mateo-berri in https://github.com/BerriAI/litellm/pull/32981
- ci(ui): report only error-level knip findings in CI by @ryan-crabbe-berri in https://github.com/BerriAI/litellm/pull/32971
- feat(batches): track cost for unmanaged Bedrock batches, generalize the flag by @Sameerlite in https://github.com/BerriAI/litellm/pull/32315
- fix(guardrails): walk custom_tool_call_output items in _content_utils by @yucheng-berri in https://github.com/BerriAI/litellm/pull/32969
- fix: show and allow editing team model aliases after team creation by @ryan-crabbe-berri in https://github.com/BerriAI/litellm/pull/33047
- chore(deps): bump pillow to 12.3.0 to resolve osv-scan CVEs by @yucheng-berri in https://github.com/BerriAI/litellm/pull/33093
- feat(mcp): mint gateway-bound envelope at the token endpoint for dcr_bridge oauth_delegate by @tin-berri in https://github.com/BerriAI/litellm/pull/32828
- fix(mcp): surface rejected delegate-auth upstream tokens as connect-time 401 by @tin-berri in https://github.com/BerriAI/litellm/pull/32741
- fix(proxy): track unauthenticated pass-through requests in spend logs by @devin-ai-integration[bot] in https://github.com/BerriAI/litellm/pull/32410
- feat(lasso): send source.type for Used By attribution by @yucheng-berri in https://github.com/BerriAI/litellm/pull/33090
- fix(responses): continue MCP gateway tool turns from the final response and surface failures by @thibault-linktree in https://github.com/BerriAI/litellm/pull/33025
- fix(responses): continue MCP gateway tool turns from the final response and surface failures by @tin-berri in https://github.com/BerriAI/litellm/pull/33099
- fix(completion): forward aws credential kwargs into litellm_params so the responses bridge keeps WIF auth by @mateo-berri in https://github.com/BerriAI/litellm/pull/32956
- fix(ui): respect litellm_key_header_name in BYOK credential save and workflow runs fetches by @ryan-crabbe-berri in https://github.com/BerriAI/litellm/pull/33103
- refactor(ui): standardize debounce waits behind shared DEBOUNCE_WAIT_MS constant by @ryan-crabbe-berri in https://github.com/BerriAI/litellm/pull/33040
- feat(ui): rebuild the Virtual Keys table on the shared DataTable by @yuneng-berri in https://github.com/BerriAI/litellm/pull/32991
- fix: redact async complete streaming response for custom callbacks by @yucheng-berri in https://github.com/BerriAI/litellm/pull/33106
- build(ui): bump @tanstack/react-pacer from 0.2.0 to 0.22.1 by @ryan-crabbe-berri in https://github.com/BerriAI/litellm/pull/33041
- fix(ui): address Virtual Keys redesign review nits by @yuneng-berri in https://github.com/BerriAI/litellm/pull/33112
- fix(openai/responses): clamp max_output_tokens below API minimum by @devin-ai-integration[bot] in https://github.com/BerriAI/litellm/pull/33098
- fix(prometheus): read v3 rate limiter remaining values for per-key model gauges by @yucheng-berri in https://github.com/BerriAI/litellm/pull/33119
- fix(ui): drop w-full from page-content wrappers to remove 32px horizontal overflow by @yuneng-berri in https://github.com/BerriAI/litellm/pull/33118
- refactor(ui): migrate straightforward value debounces to react-pacer by @ryan-crabbe-berri in https://github.com/BerriAI/litellm/pull/33042
- feat(mcp): interactive SSO sign-in for dcr_bridge oauth_delegate DCR clients by @tin-berri in https://github.com/BerriAI/litellm/pull/32946
- test(proxy): add regression tests for management_endpoints edge cases by @yuneng-berri in https://github.com/BerriAI/litellm/pull/32976
- fix(auto-router): correct Responses API tool_choice shape and propagate alias litellm_params by @krrish-berri-2 in https://github.com/BerriAI/litellm/pull/32974
- fix(ui): render the sidebar scrollbar with shadcn ScrollArea by @yuneng-berri in https://github.com/BerriAI/litellm/pull/33124
- refactor(ui): migrate callback debounce sites to react-pacer with regression tests by @ryan-crabbe-berri in https://github.com/BerriAI/litellm/pull/33043
- chore: add CODEOWNERS for ui and proxy UI build artifacts by @yuneng-berri in https://github.com/BerriAI/litellm/pull/33131
- feat(mcp): client-held refresh envelope for the dcr_bridge oauth_delegate flow by @tin-berri in https://github.com/BerriAI/litellm/pull/32980
- feat(ui): rebuild the Teams table on the shared DataTable by @yuneng-berri in https://github.com/BerriAI/litellm/pull/33128
- fix(mcp): relay upstream OAuth token and DCR rejections instead of a generic 500 by @tin-berri in https://github.com/BerriAI/litellm/pull/33113
- fix(keys): persist key_type so the UI shows correct key scope instead of "All Proxy Models" by @devin-ai-integration[bot] in https://github.com/BerriAI/litellm/pull/33115
- feat(router): opt-in session affinity for complexity router by @krrish-berri-2 in https://github.com/BerriAI/litellm/pull/33126
- feat(prometheus): expose video duration and image count consumption metrics by @yucheng-berri in https://github.com/BerriAI/litellm/pull/33138
- test(e2e): otel trace completeness on /chat/completions by @yucheng-berri in https://github.com/BerriAI/litellm/pull/33132
- fix(sso): paginate through all pages when fetching service principal group assignments by @ryan-crabbe-berri in https://github.com/BerriAI/litellm/pull/33149
- test(e2e): otel trace completeness on /v1/messages by @yucheng-berri in https://github.com/BerriAI/litellm/pull/33133
- feat(ui): add adaptive routing settings to Auto-Router v2 by @krrish-berri-2 in https://github.com/BerriAI/litellm/pull/33146
- refactor(mcp): extract the dcr_bridge token flow into bridge_token_flow.py by @tin-berri in https://github.com/BerriAI/litellm/pull/33141
- chore: bump litellm 1.93.0 -> 1.94.0, litellm-enterprise 0.1.49 -> 0.1.50, litellm-proxy-extras 0.4.76 -> 0.4.77 by @yuneng-berri in https://github.com/BerriAI/litellm/pull/33229
- fix(proxy): route master key to team-scoped models by @kunal2002 in https://github.com/BerriAI/litellm/pull/32926
- chore(deps): pin httplib2 and setuptools transitive floors by @yuneng-berri in https://github.com/BerriAI/litellm/pull/33233
- feat(ui): left-anchor the Create Key and Create Team CTAs by @yuneng-berri in https://github.com/BerriAI/litellm/pull/33248
- fix(anthropic/passthrough): drop incompatible temperature when downgrading adaptive thinking for pre-4.6 models by @devin-ai-integration[bot] in https://github.com/BerriAI/litellm/pull/33244
- fix(guardrails): run apply_guardrail-style model-level pre_call guardrails at deployment hook by @yucheng-berri in https://github.com/BerriAI/litellm/pull/33136
- fix(proxy)!: enforce user budget on team keys (read-time + reservation) with UI opt-out by @devin-ai-integration[bot] in https://github.com/BerriAI/litellm/pull/32005
- fix(e2e): bound spend-log snapshots to a /spend/logs/v2 window by @mubashir1osmani in https://github.com/BerriAI/litellm/pull/33265
- test(e2e): cover key rpm/tpm rate limiting, window reset, and pacing headers by @mateo-berri in https://github.com/BerriAI/litellm/pull/32914
- fix(anthropic): use native output capability by @krrish-berri-2 in https://github.com/BerriAI/litellm/pull/33235
- fix(ci): retry setup-uv installs to survive transient manifest fetch failures by @mateo-berri in https://github.com/BerriAI/litellm/pull/33279
- fix(proxy): never log raw virtual keys in key insertion debug output by @yucheng-berri in https://github.com/BerriAI/litellm/pull/33268
- fix(bedrock_mantle): route xai.grok-4.3 via /openai/v1 frontier path by @marty-sullivan in https://github.com/BerriAI/litellm/pull/33027
- feat(pricing): add gemini-omni-flash-preview with video output token pricing by @mateo-berri in https://github.com/BerriAI/litellm/pull/33274
- fix(auth): scope the JWT enterprise gate to actual JWTs by @mubashir1osmani in https://github.com/BerriAI/litellm/pull/33296
- fix(s3): sanitize slashes in response-id-derived object key file name by @yucheng-berri in https://github.com/BerriAI/litellm/pull/33271
- refactor(ui): migrate guardrails table onto shared DataTable by @yuneng-berri in https://github.com/BerriAI/litellm/pull/33303
- chore(ci): promote internal staging to main by @yuneng-berri in https://github.com/BerriAI/litellm/pull/33308
- feat(guardrails): streaming text transformation in generic_guardrail_api by @yucheng-berri in https://github.com/BerriAI/litellm/pull/33110
- test(e2e): cover model-aware mid-conversation system handling on Bedrock Invoke /v1/messages by @mateo-berri in https://github.com/BerriAI/litellm/pull/32963
- test(claude_code): move the Claude Code compatibility matrix under tests/e2e by @devin-ai-integration[bot] in https://github.com/BerriAI/litellm/pull/32548
- chore(ci): sync litellm_internal_staging into daily OSS branch by @yuneng-berri in https://github.com/BerriAI/litellm/pull/33337
- feat(bedrock guardrails): add resource-less InvokeGuardrailChecks (detect-only) mode by @yucheng-berri in https://github.com/BerriAI/litellm/pull/33299
- Revert "chore(ci): sync litellm_internal_staging into daily OSS branch" by @yuneng-berri in https://github.com/BerriAI/litellm/pull/33339
- fix(websearch): intercept web search on the Responses API by @devin-ai-integration[bot] in https://github.com/BerriAI/litellm/pull/33129
- … truncated upstream notes ([full notes](https://github.com/BerriAI/litellm/releases/tag/v1.94.0))
## 1.93.0-4

- Fix startup failure after Ubuntu 26.04 base upgrade (`openssl: undefined symbol: BIO_f_zlib` / Prisma `Not connected to the query engine`) by using the base image OpenSSL instead of putting Wolfi OpenSSL on `LD_LIBRARY_PATH`

## 1.93.0-3

- Update base image to Ubuntu 26.04 (Node 22 via apt; fixes Playwright MCP)

## 1.93.0-2

- Fix MCP stdio servers that use `npx` (e.g. Playwright) failing with `[Errno 2] No such file or directory` by installing `npm` alongside `nodejs`

## 1.93.0-1

- Fix Docker build for upstream v1.93.0: package Prisma from `/opt/prisma` instead of removed `/root/.cache/prisma*` paths, and pin `PRISMA_*` env vars for offline migrations

## 1.86.14-5

- Fix `aarch64` permanently and update LiteLLM to 1.86.2. Root cause of the earlier `import: command not found` crashes: litellm's versioned `vX.Y.Z-stable` images publish a broken `linux/arm64` variant whose manifest claims arm64 but contains amd64 binaries (verified on the registry), so the bundled Python could never run on aarch64 regardless of build-time platform pinning. Switched the upstream source to `ghcr.io/berriai/litellm:main-stable` (litellm's recommended, genuinely multi-arch image), pinned by its multi-arch index digest. The redundant `--platform` pin on the upstream stage was removed.

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
