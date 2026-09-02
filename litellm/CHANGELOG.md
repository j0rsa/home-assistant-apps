# Changelog

## 1.99.0

- Update upstream from `v1.98.0` to `v1.99.0` ([compare](https://github.com/BerriAI/litellm/compare/v1.98.0...v1.99.0))
- Upstream v1.99.0 ([notes](https://github.com/BerriAI/litellm/releases/tag/v1.99.0))
- chore(typing): drop 1.3k basedpyright errors across 30 Any hotspot files by @mateo-berri in https://github.com/BerriAI/litellm/pull/37073
- fix(proxy): register WebSocket passthrough for OpenAI prefixes by @LHMQ878 in https://github.com/BerriAI/litellm/pull/36151
- fix(bedrock): report uploaded size in the FileObject returned by managed batch uploads by @devin-ai-integration[bot] in https://github.com/BerriAI/litellm/pull/36392
- fix(batches): support AWS Bedrock batch cancellation via `StopModelInvocationJob` by @ArjunPakhan in https://github.com/BerriAI/litellm/pull/34087
- feat: Async Rust OCR Bridge and MCP OAuth UI Restore by @ArjunPakhan in https://github.com/BerriAI/litellm/pull/31453
- fix(batches): don't crash logging when a completed batch has no output file by @MUSE-CODE-SPACE in https://github.com/BerriAI/litellm/pull/34067
- fix(UI): add default model pin to complexity router UI by @tin-berri in https://github.com/BerriAI/litellm/pull/36615
- feat(ui): add Lite mixed-provider auto-router preset by @tin-berri in https://github.com/BerriAI/litellm/pull/37068
- feat(ui): link key info header to its user, creator, team, and organization by @ryan-crabbe-berri in https://github.com/BerriAI/litellm/pull/37187
- fix(guardrails): scan text on /guardrails/apply_guardrail for Azure Content Safety by @yucheng-berri in https://github.com/BerriAI/litellm/pull/36894
- feat(bedrock): forward LiteLLM identity and metadata into Bedrock requestMetadata by @yassin-berriai in https://github.com/BerriAI/litellm/pull/36861
- fix(azure): rename max_tokens to max_completion_tokens for gpt-5-chat deployments by @yassin-berriai in https://github.com/BerriAI/litellm/pull/36857
- fix(bedrock): preserve cache token usage when invocationMetrics replace the usage block by @brian5021 in https://github.com/BerriAI/litellm/pull/36878
- fix(proxy): registry caches stop per-request tag and end-user Postgres reads in auth by @ryan-crabbe-berri in https://github.com/BerriAI/litellm/pull/36801
- test(e2e): replay a real tool-search assistant turn back to Bedrock Invoke by @yassin-berriai in https://github.com/BerriAI/litellm/pull/36856
- fix(proxy): return 400 naming the missing required param on POST /v1/batches by @mateo-berri in https://github.com/BerriAI/litellm/pull/37199
- fix(ci): bump sqlparse to 0.6.0 to resolve osv-scan CVEs by @mateo-berri in https://github.com/BerriAI/litellm/pull/37200
- fix(ui): stop pairing key spend with the team budget when a key has no budget by @ryan-crabbe-berri in https://github.com/BerriAI/litellm/pull/37196
- fix(guardrails): record MCP tool guardrail evaluations and blocks in … by @Scott-Wilson-ZocDoc in https://github.com/BerriAI/litellm/pull/36978
- fix(proxy): return 400 for non-object metadata and litellm_metadata instead of silent drop or 500 by @mateo-berri in https://github.com/BerriAI/litellm/pull/37203
- fix(anthropic): preserve optional Responses tool properties by @Scott-Wilson-ZocDoc in https://github.com/BerriAI/litellm/pull/36979
- feat(ui): add user ID request log filter by @daniel-meismer-zocdoc in https://github.com/BerriAI/litellm/pull/36781
- fix(anthropic): stop emitting empty thinking blocks on the Responses adapter by @Scott-Wilson-ZocDoc in https://github.com/BerriAI/litellm/pull/36033
- fix(ui): make per-user usage filter searchable by @daniel-meismer-zocdoc in https://github.com/BerriAI/litellm/pull/36790
- refactor(ui): decouple bulk invite from the invite user button by @yuneng-berri in https://github.com/BerriAI/litellm/pull/37061
- fix(helm): bound the migrations Job so a blocked migration cannot stall the release by @yuneng-berri in https://github.com/BerriAI/litellm/pull/36975
- feat(proxy): let USE_V2_MIGRATION_RESOLVER select the v2 migration resolver by @yuneng-berri in https://github.com/BerriAI/litellm/pull/36258
- fix(mcp): scope authorization server issuer by @irosh-colombage-ZocDoc2 in https://github.com/BerriAI/litellm/pull/36482
- fix(responses): unwrap object-form tool_choice before calling the Responses API by @Scott-Wilson-ZocDoc in https://github.com/BerriAI/litellm/pull/36032
- test(ui): query antd controls accessibly instead of by internal CSS class by @yuneng-berri in https://github.com/BerriAI/litellm/pull/37014
- fix(proxy): bill cancelled and failed batches that still produced an output file by @mateo-berri in https://github.com/BerriAI/litellm/pull/37205
- fix(bedrock): read batch usage by payload shape, not by provider name by @marty-sullivan in https://github.com/BerriAI/litellm/pull/37078
- fix(ui): self-contained searchable user filter on the Usage page by @ryan-crabbe-berri in https://github.com/BerriAI/litellm/pull/37206
- revert: don't fix mcp scope authorization server issuer by @mateo-berri in https://github.com/BerriAI/litellm/pull/37220
- fix(mcp): scope authorization server issuer for named MCP servers by @yucheng-berri in https://github.com/BerriAI/litellm/pull/37204
- test(ui): gate dashboard test assertions with testing-library and jest-dom rules by @yuneng-berri in https://github.com/BerriAI/litellm/pull/37018
- feat(shadow-eval): name the shadowed key in job responses and the UI headline by @tin-berri in https://github.com/BerriAI/litellm/pull/37221
- test(ui): assert what collaborators are called with, not merely that they were by @yuneng-berri in https://github.com/BerriAI/litellm/pull/37019
- fix(logging): stop deepcopying results redaction cannot redact by @marty-sullivan in https://github.com/BerriAI/litellm/pull/36638
- fix(gemini): price gemini 3.6 flash at Google's introductory rates on every service tier by @devin-ai-integration[bot] in https://github.com/BerriAI/litellm/pull/37197
- perf(guardrails): stop sending the conversation twice in the noma v2 payload by @itaimodi in https://github.com/BerriAI/litellm/pull/36764
- fix(streaming): track provider-reported cost when caller omits include_usage by @devin-ai-integration[bot] in https://github.com/BerriAI/litellm/pull/35013
- fix: stop rust flag from leaking into upstream provider request bodies by @mateo-berri in https://github.com/BerriAI/litellm/pull/37218
- fix(proxy): return 404 instead of 500 for unresolvable batch and file ids on /v1/batches by @mateo-berri in https://github.com/BerriAI/litellm/pull/37201
- fix(bedrock): validate file-content retrieval against the configured output bucket (#26335) by @kingdoooo in https://github.com/BerriAI/litellm/pull/31435
- fix(proxy): reject out-of-range limit on GET /v1/batches with OpenAI-parity 400 by @mateo-berri in https://github.com/BerriAI/litellm/pull/37198
- fix(batches): price a retrieved batch from its deployment's model and rates (internal copy of #37077) by @mateo-berri in https://github.com/BerriAI/litellm/pull/37219
- feat(ocr): return Azure Document Intelligence's native payload from /v1/ocr via req_format=native by @devin-ai-integration[bot] in https://github.com/BerriAI/litellm/pull/37194
- fix(anthropic): fold guardrail-modified leading system rows into top-level system param by @mateo-berri in https://github.com/BerriAI/litellm/pull/37231
- fix(shadow_eval): copy messages before router call and raise judge output cap by @tin-berri in https://github.com/BerriAI/litellm/pull/37232
- feat(proxy): add Amazon Comprehend Medical passthrough provider by @mateo-berri in https://github.com/BerriAI/litellm/pull/37229
- test(ui): settle the in-flight search before the loading tests end by @yuneng-berri in https://github.com/BerriAI/litellm/pull/37227
- test(cli): use example.com placeholder host in base-url trailing slash test by @ryan-crabbe-berri in https://github.com/BerriAI/litellm/pull/37240
- feat(complexity_router): operator-defined tier sets for the LLM classifier by @tin-berri in https://github.com/BerriAI/litellm/pull/37226
- feat(ui): configure the auto router's heuristic scorer from the Admin UI by @tin-berri in https://github.com/BerriAI/litellm/pull/37216
- fix(shadow_eval): drop unused judge reasoning field and salvage truncated verdicts by @tin-berri in https://github.com/BerriAI/litellm/pull/37239
- feat(proxy): proactive model deprecation alerts and `/model/deprecations` endpoint by @mateo-berri in https://github.com/BerriAI/litellm/pull/26900
- refactor(ui): move dashboard toasts from antd message/notification onto sonner by @ryan-crabbe-berri in https://github.com/BerriAI/litellm/pull/37207
- feat(guardrails): track bedrock guardrail usage units per invocation by @mateo-berri in https://github.com/BerriAI/litellm/pull/37225
- fix(proxy): strip callback credentials from the auth object stamped into request metadata by @yucheng-berri in https://github.com/BerriAI/litellm/pull/37233
- fix(guardrails): retry usage upserts only on connection errors by @mateo-berri in https://github.com/BerriAI/litellm/pull/37247
- fix(mcp): oauth discovery must not cause outages by @daniel-meismer-zocdoc in https://github.com/BerriAI/litellm/pull/36599
- test(ui): await the playground model combobox before clicking it by @yuneng-berri in https://github.com/BerriAI/litellm/pull/36850
- refactor(ui): migrate budget and skill forms to react-hook-form and shadcn by @yuneng-berri in https://github.com/BerriAI/litellm/pull/37262
- refactor(ui): migrate tag and memory forms to react-hook-form and shadcn by @yuneng-berri in https://github.com/BerriAI/litellm/pull/37266
- feat(complexity_router): plan-mode tier floor for coding-agent clients by @tin-berri in https://github.com/BerriAI/litellm/pull/37230
- refactor(ui): codemod every toast call site onto lib/toast and delete the antd-era facades by @ryan-crabbe-berri in https://github.com/BerriAI/litellm/pull/37253
- feat(proxy): add /team/daily/activity/aggregated and switch the Usage team tab to it by @ryan-crabbe-berri in https://github.com/BerriAI/litellm/pull/36562
- refactor(ui): migrate user, logging and policy forms to react-hook-form and shadcn by @yuneng-berri in https://github.com/BerriAI/litellm/pull/37303
- refactor(ui): migrate user, policy, and margin forms to shadcn by @yuneng-berri in https://github.com/BerriAI/litellm/pull/37305
- refactor(ui): migrate the regenerate key and team member forms to react-hook-form and shadcn by @yuneng-berri in https://github.com/BerriAI/litellm/pull/37300
- refactor(ui): migrate CloudZero and cost tracking forms to react-hook-form and shadcn by @yuneng-berri in https://github.com/BerriAI/litellm/pull/37312
- refactor(ui): migrate auto router and credential forms to react-hook-form and shadcn by @yuneng-berri in https://github.com/BerriAI/litellm/pull/37304
- refactor(ui): migrate guardrail and vector store forms to react-hook-form and shadcn by @yuneng-berri in https://github.com/BerriAI/litellm/pull/37306
- refactor(ui): migrate prompt, UI access, plugin and MCP filter forms to react-hook-form and shadcn by @yuneng-berri in https://github.com/BerriAI/litellm/pull/37297
- refactor(ui): drop the unreachable user edit modal by @yuneng-berri in https://github.com/BerriAI/litellm/pull/37327
- fix(router): route Responses API input through the auto-router by @mateo-berri in https://github.com/BerriAI/litellm/pull/37333
- refactor(ui): migrate the login, onboarding and search tool forms to react-hook-form and shadcn by @yuneng-berri in https://github.com/BerriAI/litellm/pull/37334
- feat(ui): plan-mode override tier in the auto-router create and edit forms by @tin-berri in https://github.com/BerriAI/litellm/pull/37319
- … truncated upstream notes ([full notes](https://github.com/BerriAI/litellm/releases/tag/v1.99.0))
## 1.98.0

- Update upstream from `v1.97.0` to `v1.98.0` ([compare](https://github.com/BerriAI/litellm/compare/v1.97.0...v1.98.0))
- Upstream v1.98.0 ([notes](https://github.com/BerriAI/litellm/releases/tag/v1.98.0))
- fix(bedrock): drop toolSpec.strict for Claude Sonnet 5 on Converse by @kr0k in https://github.com/BerriAI/litellm/pull/33196
- fix(batches): attribute Vertex passthrough batch cost to key/team/tags by @yucheng-berri in https://github.com/BerriAI/litellm/pull/34456
- docs: rewrite the CLAUDE.md comment rule with explicit exceptions by @devin-ai-integration[bot] in https://github.com/BerriAI/litellm/pull/36301
- fix(proxy): scope file list pagination cursors to the caller by @devin-ai-integration[bot] in https://github.com/BerriAI/litellm/pull/36093
- fix(proxy): skip prisma-dependent hooks when no database is attached by @mateo-berri in https://github.com/BerriAI/litellm/pull/36273
- fix(proxy): report has_more false on caller-scoped file list pages by @mateo-berri in https://github.com/BerriAI/litellm/pull/36326
- fix(proxy): restore management_v1 query-param validation under fastapi>=0.140.7 by @HuanQian571 in https://github.com/BerriAI/litellm/pull/35773
- fix(proxy): stop /{provider}/v1/files from capturing /openai_passthrough by @devin-ai-integration[bot] in https://github.com/BerriAI/litellm/pull/36092
- chore(typing): remove 914 basedpyright Any errors across 16 hotspot files by @mateo-berri in https://github.com/BerriAI/litellm/pull/36386
- fix(router): keep batch fallbacks inside the model group that owns the file by @mateo-berri in https://github.com/BerriAI/litellm/pull/36181
- feat(ptu): configure provisioned-throughput flat cost on a model deployment by @yucheng-berri in https://github.com/BerriAI/litellm/pull/35341
- docs: clarify the CLAUDE.md comment exceptions are any-of by @devin-ai-integration[bot] in https://github.com/BerriAI/litellm/pull/36421
- docs: replace the Changes PR template section with Caveats by @devin-ai-integration[bot] in https://github.com/BerriAI/litellm/pull/36423
- fix(bedrock): enable native structured output for GLM 5 and DeepSeek V3.2 by @alexshtf in https://github.com/BerriAI/litellm/pull/35669
- feat(ptu): daily rollup writes per-model PTU flat cost by active hour by @yucheng-berri in https://github.com/BerriAI/litellm/pull/35343
- feat(logging): add opt-in session_id and trace_id correlation to JSON log records via contextvars by @deepanshululla in https://github.com/BerriAI/litellm/pull/34418
- feat(ptu): surface PTU flat cost on the daily activity read path by @yucheng-berri in https://github.com/BerriAI/litellm/pull/35391
- feat(router): add per-deployment allowed_fails_policy and cooldown_time override support by @deepanshululla in https://github.com/BerriAI/litellm/pull/34416
- feat(ptu): add PTU inputs to the model form and flat cost to the Usage page by @yucheng-berri in https://github.com/BerriAI/litellm/pull/35393
- fix(cost): price dict-shaped image input token details at the image rate by @vairodp in https://github.com/BerriAI/litellm/pull/33490
- fix(model_prices): refresh deprecation dates, correct xAI pricing and add missing provider models by @devin-ai-integration[bot] in https://github.com/BerriAI/litellm/pull/36403
- feat(ptu): gate PTU flat-cost attribution behind an opt-in env var by @yucheng-berri in https://github.com/BerriAI/litellm/pull/36138
- ci: cache Prisma CLI and engine binaries, split test timeout from setup by @mateo-berri in https://github.com/BerriAI/litellm/pull/36417
- feat(rate limiting): configurable estimated output tokens per key, team and model by @yassin-berriai in https://github.com/BerriAI/litellm/pull/36143
- fix(ui): hide admin-only Logs tabs from roles that cannot call their endpoints by @yuneng-berri in https://github.com/BerriAI/litellm/pull/36333
- test(proxy): guard management_v1 against fastapi names removed in supported releases by @yuneng-berri in https://github.com/BerriAI/litellm/pull/36336
- fix(ui): gate policy and prompt lookups on an admin capability by @yuneng-berri in https://github.com/BerriAI/litellm/pull/36335
- build(deps): bump pypdf to 6.15.0 to clear osv-scan by @devin-ai-integration[bot] in https://github.com/BerriAI/litellm/pull/36350
- fix(proxy): isolate guardrail load failures per row by @yucheng-berri in https://github.com/BerriAI/litellm/pull/36432
- fix(ui): gate organization and agent usage views behind capabilities by @yuneng-berri in https://github.com/BerriAI/litellm/pull/36334
- fix(reset_budget_job): atomic budget cascade with chunked reset scans by @ryan-crabbe-berri in https://github.com/BerriAI/litellm/pull/36287
- feat(proxy): add GET /v1/indexes to list vector store indexes by @ryan-crabbe-berri in https://github.com/BerriAI/litellm/pull/36289
- feat(ui): show vector store indexes on the Vector Stores page by @ryan-crabbe-berri in https://github.com/BerriAI/litellm/pull/36306
- fix(proxy): treat SAML as configured in UI SSO detection by @fancybear-dev in https://github.com/BerriAI/litellm/pull/36196
- fix(bedrock): reject Anthropic server-side web_search tool with actionable error by @ryan-crabbe-berri in https://github.com/BerriAI/litellm/pull/36473
- fix(ui): open the classifier prompt editor above the edit auto-router form by @tin-berri in https://github.com/BerriAI/litellm/pull/36438
- fix(arize): trace MCP tool calls instead of crashing on CallToolResult by @yucheng-berri in https://github.com/BerriAI/litellm/pull/36453
- refactor(ui): make illegal DataTable prop combinations unrepresentable by @yuneng-berri in https://github.com/BerriAI/litellm/pull/36470
- fix(ui): scope Virtual Keys and Logs team lists to the caller by @yuneng-berri in https://github.com/BerriAI/litellm/pull/36472
- fix(ui): gate the Old Usage page behind a proxy-admin capability by @yuneng-berri in https://github.com/BerriAI/litellm/pull/36469
- docs(terraform): describe the provider release as automatic by @yuneng-berri in https://github.com/BerriAI/litellm/pull/36467
- feat(proxy): add per-deployment keepalive_seconds SSE heartbeat to prevent load-balancer timeout on long streams by @deepanshululla in https://github.com/BerriAI/litellm/pull/34423
- fix(router): cool down failed fallback deployments and correct cooldown TTL after Redis backfill by @deepanshululla in https://github.com/BerriAI/litellm/pull/35104
- perf(spend): write each daily spend batch in one upsert statement by @yassin-berriai in https://github.com/BerriAI/litellm/pull/36448
- fix(ui): gate four sidebar pages on the roles their endpoints allow by @yuneng-berri in https://github.com/BerriAI/litellm/pull/36475
- fix(ui): restore the Logs Deleted Teams tab for organization admins by @yuneng-berri in https://github.com/BerriAI/litellm/pull/36478
- fix(websearch): stop leaking interception control fields to providers by @yassin-berriai in https://github.com/BerriAI/litellm/pull/36480
- test(e2e): cover the Anthropic web_search server tool on Bedrock by @yassin-berriai in https://github.com/BerriAI/litellm/pull/36443
- fix(router): warn when a deployment's credentials contradict its provider by @yassin-berriai in https://github.com/BerriAI/litellm/pull/36486
- fix: net prompt-caching savings against the cache-write premium by @tin-berri in https://github.com/BerriAI/litellm/pull/36452
- feat(ui): deployment affinity toggle for the auto-router by @tin-berri in https://github.com/BerriAI/litellm/pull/36302
- fix(bedrock): use deployment credentials for AWS requests by @daleselaji-dev in https://github.com/BerriAI/litellm/pull/36160
- fix(anthropic): preserve midturn system corrections by @eugene-yao-zocdoc in https://github.com/BerriAI/litellm/pull/34290
- fix(email): stop duplicate legacy invitation email and fix its onboarding link by @mubashir1osmani in https://github.com/BerriAI/litellm/pull/36455
- feat(ui): show models under each tier in routing benchmark chart by @tin-berri in https://github.com/BerriAI/litellm/pull/36291
- fix(proxy): inject streaming usage cost on openai passthrough streams by @mateo-berri in https://github.com/BerriAI/litellm/pull/36503
- docs: require a user flow and live-proxy proof in bug reports by @devin-ai-integration[bot] in https://github.com/BerriAI/litellm/pull/36498
- fix(proxy): add config_updated_at audit timestamp for virtual keys by @ryan-crabbe-berri in https://github.com/BerriAI/litellm/pull/36488
- docs: require a user flow and a stuck-at proof in feature requests by @devin-ai-integration[bot] in https://github.com/BerriAI/litellm/pull/36500
- feat(router): add required-AND (&) tag prefix and allow_fail_open flag by @deepanshululla in https://github.com/BerriAI/litellm/pull/36193
- feat(proxy): per-key prompt caching toggle via enable_prompt_caching by @ryan-crabbe-berri in https://github.com/BerriAI/litellm/pull/36466
- fix(bedrock): send tool-search beta header for Haiku 4.5 on Invoke /v1/messages by @mateo-berri in https://github.com/BerriAI/litellm/pull/36502
- fix(bedrock): preserve adaptive thinking effort through the /v1/messages bridge by @mateo-berri in https://github.com/BerriAI/litellm/pull/36507
- ci: retry transient network fetch failures in lint workflow by @mateo-berri in https://github.com/BerriAI/litellm/pull/36563
- fix(ui): stub useIsOrgAdmin in UsageTab tests so useCan needs no QueryClient by @ryan-crabbe-berri in https://github.com/BerriAI/litellm/pull/36565
- fix(alerting): dedupe scheduled Slack spend reports across pods by @ryan-crabbe-berri in https://github.com/BerriAI/litellm/pull/36489
- chore(typing): clear 1.6k basedpyright Any errors across 56 files by @mateo-berri in https://github.com/BerriAI/litellm/pull/36543
- fix(bedrock): add text block to converse user messages carrying documents by @mateo-berri in https://github.com/BerriAI/litellm/pull/36499
- fix(deps): ship boto3 with the base SDK so bedrock works out of the box by @mubashir1osmani in https://github.com/BerriAI/litellm/pull/36568
- fix(model_prices): add provider-announced deprecation dates for Bedrock, Mistral, Cohere and Gemini models by @devin-ai-integration[bot] in https://github.com/BerriAI/litellm/pull/36538
- chore: bump litellm-enterprise 0.1.54 -> 0.1.55, litellm-proxy-extras 0.4.84 -> 0.4.85, litellm 1.97.0 -> 1.98.0 by @yuneng-berri in https://github.com/BerriAI/litellm/pull/36577
- fix(bedrock_guardrails): skip ApplyGuardrail when there is no content to scan by @yucheng-berri in https://github.com/BerriAI/litellm/pull/36441
- fix(e2e): assert on the gen-AI span that served the stream, not the span count by @yassin-berriai in https://github.com/BerriAI/litellm/pull/36582
- test(e2e): harden vendor API coverage by @mubashir1osmani in https://github.com/BerriAI/litellm/pull/34557
- test(e2e): add reproducers for passthrough and model budget gaps by @mubashir1osmani in https://github.com/BerriAI/litellm/pull/34657
- test(e2e): cover google-native generateContent framing and prometheus queue time by @mubashir1osmani in https://github.com/BerriAI/litellm/pull/34650
- chore(ci): promote internal staging to main by @tin-berri in https://github.com/BerriAI/litellm/pull/36560
- feat(router): make routing groups callable as virtual models and list them in /v1/models by @tin-berri in https://github.com/BerriAI/litellm/pull/36519
- fix(xai): bill web_search from server_side_tool_usage_details by @geraint0923 in https://github.com/BerriAI/litellm/pull/30817
- … truncated upstream notes ([full notes](https://github.com/BerriAI/litellm/releases/tag/v1.98.0))
## 1.97.0

- Update upstream from `v1.96.2` to `v1.97.0` ([compare](https://github.com/BerriAI/litellm/compare/v1.96.2...v1.97.0))
## 1.96.2

- Update upstream from `v1.96.0` to `v1.96.2` ([compare](https://github.com/BerriAI/litellm/compare/v1.96.0...v1.96.2))
- Upstream v1.96.2 ([notes](https://github.com/BerriAI/litellm/releases/tag/v1.96.2))
- chore(release): backport proxy request-handling maintenance and refresh runtime deps for 1.96.1 by @yuneng-berri in https://github.com/BerriAI/litellm/pull/36494
- bump: version 1.96.1 → 1.96.2 (1.96.1 burned by the PyPI storage failure) by @yuneng-berri in https://github.com/BerriAI/litellm/pull/36570
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
