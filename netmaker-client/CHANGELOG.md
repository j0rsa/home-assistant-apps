# Changelog

## 1.8.0

- Track the netclient version with Renovate (`NETCLIENT_VERSION` build arg) so it updates automatically
- Update upstream from `v1.6.0` to `v1.8.0` ([compare](https://github.com/gravitl/netclient/compare/v1.6.0...v1.8.0))
- Upstream v1.7.0 ([notes](https://github.com/gravitl/netclient/releases/tag/v1.7.0))
- Sends `X-Tenant-ID` on API requests so host actions are scoped to the correct tenant.
- Prevents registering into a different tenant on a server the host is already joined to.
- Uninstall, leave, and host cleanup use the correct token and tenant context; switching servers updates tenant state cleanly.
- Gateways can enable a TCP proxy listener (`tcp_proxy_enabled`, listen port/addr, TLS mode).
- Relayed clients dial the gateway over WSS (`wss://…/uplink/v1`) and authenticate with WireGuard key proofs.
- Supports **self-signed** and **reverse-proxy / externally terminated TLS** modes.
- Userspace WireGuard bind routes uplink peers through the proxy; disabling TCP uplink returns to kernel WireGuard without hanging.
- Gathers hostname, serial, hardware UUID, and Entra device ID (platform-specific collectors for Linux, macOS, and Windows).
- Sets MDM posture fields on registration and publishes identity for server-side Intune / Jamf / JumpCloud / Iru evaluation.
- New CLI: `netclient posture status` (server-evaluated results) and `netclient posture identity` (local identity snapshot).
- Dual-stack default routes and per-family gateway detection (including Windows default-gateway lookup by IP family).
- Exit-node UI/API fields wired through for dual-stack internet gateways.
- IPv6 NAT / masquerade rules for iptables and nftables egress endpoints.
- Reapply exit routes after IGW monitor goes unhealthy and on `ReplacePeers` peer updates.
- Improved IGW monitor status management and thread safety; don’t start the monitor with an empty gateway peer.
- Fixed nftables port rules and restored egress MASQUERADE on the default interface (keep primary masquerade; skip only LAN-to-VPN SNAT when egress uses the WAN iface).
- IPv6 NAT handling for iptables and nftables.
- Refresh the public listen port independently of a static endpoint (STUN for dynamic port even when the endpoint is static, and vice versa).
- Skip hole punch only when both endpoint and port are static.
- Go toolchain updated to **1.26.0**.
- IPv6-only machines**
- Multi-network join performance**
- systemd-resolved DNS limitation**
- Upstream v1.8.0 ([notes](https://github.com/gravitl/netclient/releases/tag/v1.8.0))
- Now available to **CE users** as well (previously limited to Pro/EE).
- Peer-to-peer by default** — desktop devices join the mesh with direct WireGuard peering (not gateway-only), for lower latency and better connectivity.
- Separate **desktop** and **headless** builds (`-tags desktop`) so GUI session, tray, and device APIs stay isolated from server/daemon installs.
- Fresh UI and connection flow for connecting to networks and exit nodes.
- Improved status visibility for tunnel state and exit modes.
- Auto Exit** — when enabled on a network (`auto_select_exit_node`), desktop/user devices are automatically assigned an allowed internet exit (nearest available) when they connect; users can still switch exits when permitted.
- When the host has **Manage SSH** enabled, netclient starts the embedded SSH server and listens on the mesh.
- Access is limited to peers that can reach the host over Netmaker.
- Useful for admin access, file transfer, and operational workflows on enrolled devices.
- Advertise egress ranges and route mesh traffic to attached LAN/site networks on Windows.
- Uses **Hyper-V NetNat** for egress NAT and **WFP** for peer/host and egress ACL enforcement.
- Improved multi-network egress routing (correct nexthop / on-link handling on Windows).
- Why:** Without bypass, clients using an internet exit often send site-egress traffic up to the exit node and back out again (hairpin), adding latency and load.
- When bypass is enabled, allowed site egress stays as **direct WireGuard peers** so traffic to those sites flows peer-to-peer instead of bending through the exit.
- Stop Desktop exit flap on `ChangeDefaultGw=false` races; finish deferred IGW teardown when select/restore ends.
- Preserve internet-exit routes across connect/disconnect and iface rebuilds; correct multi-net exit source selection on Darwin/Windows.
- Defer exit latency probes until after connect so listing stays non-blocking; allow UI exit list while disconnected for restore.
- Keep host enrollment on Desktop logout; transfer ownership on re-login; recover orphaned `:53` listeners after login/logout.
- Lower CPU use for auto-relay; keep auto-relay on pull by default.
- `netclient pull --reset-connections` for a one-shot peer/auto-relay reset; one-shot auto-relay scan after peers land (handshake grace).
- Reinstall egress after iface rebuild; skip unchanged egress on peer update; clear leftover Windows on-link routes.
- Windows multi-net egress via GW nexthop (parity with Linux Src/Gw behavior).
- nftables metrics port encoded in network order; IPv6 NAT handling for iptables and nftables.
- Default-deny inbound on Desktop (Darwin pf); skip server FW rules where appropriate.
- Re-register once when session pull returns unauthorized.
- Use user JWT for owned-device control-plane auth; deprecate join-with-user-auth flows.
- ECDH-derived AES keys for decrypting server messages.
- Refresh the public listen port independently of a static endpoint (STUN for dynamic port even when the endpoint is static, and vice versa).
- Skip hole punch only when both endpoint and port are static.
- Skip STUN and IP detection for relayed devices.
- Separate desktop and headless build tags; Go toolchain updated to **1.26.0**.
- IPv6-only machines**
- Multi-network join performance**
- systemd-resolved DNS limitation**
## 1.6.0-5

- Rebuild images after codenotary/`app_config` migration so CI publishes updated manifests

## 1.6.0-4

- Remove deprecated `codenotary` field from config and build metadata
- Replace legacy `addon_config` map type with `app_config`

## 1.6.0-3

- Use host networking so netclient can manage WireGuard on the HA host

## 1.6.0-2

- Do not run `netclient version` during image build (it initializes WireGuard and fails in CI)

## 1.6.0-1

- Fail the image build if netclient download fails, is empty, or is not an ELF binary
- Fix netclient download URL (`releases/download/v1.6.0/...`)

## 1.6.0

- Remove SOCKS proxy, redsocks, and tun2socks integration
- Run plain netclient join + daemon only
- Remove `socks_proxy`, `wg_2_socks_proxy`, `wg_interface`, and `log_level` options

## 1.5.2

- Update base image to Alpine 3.24

## 1.1.0

- Rename add-on from netmaker to netmaker-client to avoid naming clash with new controller add-on

## 1.0.13

- Remove armv7 architecture support
