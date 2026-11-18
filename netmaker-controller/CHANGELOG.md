# Changelog

## 1.8.0

- Update upstream from `v1.7.0` to `v1.8.0` ([compare](https://github.com/gravitl/netmaker/compare/v1.7.0...v1.8.0))
- Upstream v1.8.0 ([notes](https://github.com/gravitl/netmaker/releases/tag/v1.8.0))
- Now available to **CE users** as well (previously limited to Pro/EE).
- Peer-to-peer by default** — desktop devices join the mesh with direct peering (not gateway-only), for lower latency and better connectivity.
- Fresh UI and connection flow for connecting to networks and exit nodes.
- Improved status visibility for tunnel state and exit modes.
- Auto Exit** — when enabled on a network (`auto_select_exit_node`), desktop/user devices are automatically assigned an allowed internet exit (nearest available) when they connect; users can still switch exits when permitted.
- Enable **Manage SSH** on hosts so netclient runs an embedded SSH/SCP/SFTP server.
- Access mesh hosts over Netmaker with centralized control of who can connect.
- Useful for admin access, file transfer, and operational workflows on enrolled devices.
- Improved layout and visualization of users, devices, servers, and config clients.
- Easier navigation of network relationships and host locations.
- Better at-a-glance view of how your mesh is connected.
- Advertise egress ranges from Windows netclients.
- Route traffic from the mesh to attached LAN/site networks via Windows.
- Uses Windows NetNat where required for egress NAT.
- Why:** Without bypass, clients using an internet exit often send site-egress traffic up to the exit node and back out again (hairpin), adding latency and load. Bypass keeps allowed site egress as **direct peers**, so traffic to those sites flows peer-to-peer instead of bending through the exit.
- `bypass_egress_routes`** (internet egress only) — enable to avoid that hairpin for other egress sites; disable to force site-egress traffic via the internet exit.
- Configurable on create/update; defaults to **on** for new internet egress.
- Ignored for non-internet (site) egress types.
- Migrates **extclients**, **ACLs**, **tags**, and **DNS entries** into `*_v1` schema tables (network resolved by name within tenant).
- Adds **slugs** / **UUIDs** (and role **scope**) for user groups and user roles.
- Lowercases **email usernames** where the username is an email address.
- Clears legacy **`owner_username`** values on hosts (re-established by current device ownership flows).
- Backfills **IP address pools and allocations** from existing node/extclient addresses.
- Sets **`bypass_egress_routes=true`** on existing internet egress rows that predate the option (one-shot; later admin `false` is preserved).
- Migrates legacy **internet gateways** (`IsInternetGateway`) into **internet-type egress** resources and exit-node selections.
- Backfills **`network_global_access`** on default network-admin roles.
- You **must** run **Netmaker v1.7.0** successfully **before** upgrading to v1.8.0.
- v1.8.0 will **refuse to start** if `migration-v1.7.0` has not completed on a prior v1.7.0 deployment.
- Recommended path: deploy v1.7.0 → confirm the server starts cleanly → then upgrade to v1.8.0.
- Do not** jump from v1.6.x (or earlier) straight to v1.8.0 on an existing database.
- If a network has the **same overlay IP** on more than one node or extclient, **`migration-v1.8.0` will fail** until duplicates are resolved.
- Fix duplicate addresses in the UI/API, then retry the upgrade.
- Schema and data are updated automatically on successful startup.
- Downgrades may not be supported after migration.
- Confirm `migration-v1.7.0` completed on v1.7.0 before moving to v1.8.0.
- Resolve any duplicate overlay IPs before upgrading.
- Ensure migrations complete and validate networks, ACLs, tags, DNS, and exit/egress behavior post-upgrade.
- Migration reliability** — v1.8.0 blocks startup until `migration-v1.7.0` completed on existing deployments; IP pool backfill fails clearly on duplicate addresses instead of corrupting allocations.
- IP address management** — Networks gain managed IP pools/allocations; pools are synced on startup so existing networks can allocate addresses safely.
- Auto-relay performance** — Lower CPU use for auto-relay; API to list auto-relayed peers for a node; reset a specific auto-relayed peer pair without resetting the whole network.
- User-device / desktop ACL paths** — CE supports user ACL policies with All Users and per-user sources; AllowAll is preserved when both default policies are open; FwUpdate calc skipped for user-owned devices where appropriate.
- Exit node + relay** — Selecting an exit node can replace an existing relay; alternate exit peers limited to user devices (servers continue to hairpin via the selected exit).
- Host / device auth** — Reject host-password JWTs for user-owned devices; AuthorizeHost accepts a user session plus `X-Host-ID`. Network-role API access tightened for network admins.
- Extclient reliability** — Bulk create API and faster creation; mark extclients offline when their ingress gateway is unreachable; keep static WireGuard configs across JIT, IdP, and access cleanup paths.
- Topology / map data** — Topology and connections enriched with location, gateway flags, and egress context.
- Device join resilience** — Device join/pull tolerates `host.Nodes` drift vs live nodes.
- Account lifecycle** — Force logout and user-device cleanup when disabling/deleting user accounts; username filter on nodes API.
- Email usernames** — Email-style usernames normalized to lowercase (invites and migration).
- Traffic keys** — AES key derivation via ECDH; stronger validation of traffic public keys.
- IPv6-only machines**
- Multi-network join performance**
- systemd-resolved DNS limitation**
- Windows Desktop App + mixed gateway modes**
- a **Full Tunnel Gateway**, and
- a **Split Tunnel Gateway**
- Duplicate overlay IPs block v1.8.0 migration**
## 1.7.0

- Update upstream from `v1.6.0` to `v1.7.0` ([compare](https://github.com/gravitl/netmaker/compare/v1.6.0...v1.7.0))
- Upstream v1.7.0 ([notes](https://github.com/gravitl/netmaker/releases/tag/v1.7.0))
- Organizations & tenants** - Group customers under an organisation; each tenant is an isolated Netmaker environment (networks, devices, users).
- MSP license sync** - EE/MSP installs create and update orgs/tenants from the MSP license (including teardown when a tenant is removed from the license). CE and normal Pro accounts continue to use a single local default tenant.
- Scoped access** - API and `nmctl` select the target org/tenant via `X-Organization-ID` / `X-Tenant-ID` (`--org_id` / `--tenant_id`), with `nmctl organisation list` and `nmctl tenant list` for discovery.
- Enable TCP proxy on the gateway/host (`tcp_proxy_enabled` and related listen/TLS settings).
- Clients can opt into a TCP uplink to the gateway when the proxy is enabled.
- Supports self-signed and externally terminated TLS modes for WSS endpoints.
- Supported providers: **Microsoft Defender**, **CrowdStrike**, **SentinelOne**, and **Wazuh**.
- Sync managed endpoints and evaluate EDR compliance (agent health/risk level) as part of device posture.
- Configure, test, and manage integrations via the REST API (`/api/v1/integrations/edr/{provider}`).
- Supported providers: **Microsoft Intune**, **Jamf**, **JumpCloud**, and **Iru**.
- Match devices by Entra device ID, serial number, hardware UUID, or hostname.
- Enforce MDM enrollment/compliance checks alongside existing posture policies.
- Configure, test, and manage integrations via the REST API (`/api/v1/integrations/mdm/{provider}`).
- You **must** run **Netmaker v1.6.0** successfully **before** upgrading to v1.7.0.
- v1.7.0 will **refuse to start** if `migration-v1.6.0` has not completed on a prior v1.6.0 deployment.
- Recommended path: deploy v1.6.0 → confirm the server starts cleanly → then upgrade to v1.7.0.
- Schema and data are updated automatically on successful startup.
- Downgrades may not be supported after migration.
- Do not jump from v1.5.x (or earlier) straight to v1.7.0 on an existing database.
- Ensure migrations complete and validate core functionality post-upgrade.
- Auto-relay peer reset** - Reset a specific peer-to-peer connection that is using a relay (clear/reassign auto-relay for that peer pair) without resetting the entire network’s auto-relay state.
- Host status** - Host filtering uses live check-in status (Online/Offline/Disconnected) rather than a stale DB value.
- MSP installs** - `nm-quick.sh` `-s` flag to skip nmctl/mesh/netclient on MSP server installs.
- IPv6-only machines**
- Multi-network join performance**
- systemd-resolved DNS limitation**
- Windows Desktop App + mixed gateway modes**
- a **Full Tunnel Gateway**, and
- a **Split Tunnel Gateway**
## 1.6.0.1-2

- Rebuild images after codenotary/`app_config` migration so CI publishes updated manifests

## 1.6.0.1-1

- Remove deprecated `codenotary` field from config and build metadata
- Replace legacy `addon_config` map type with `app_config`

## 1.6.0.1

- Update base image to Alpine 3.24

## 1.5.0.3

- Fix APIHost: set SERVER_HTTP_HOST to NM_DOMAIN, leave SERVER_HOST for auto-detection
- Add mq_public_endpoint option for the broker address sent to joining clients (BROKER_ENDPOINT)
- SERVER_BROKER_ENDPOINT remains the internal server-to-broker connection

## 1.5.0.2

- Fix enrollment token address: default SERVER_HOST to NM_DOMAIN so clients connect via domain/tunnel instead of raw public IP
- Update translations to clarify domain vs server host override

## 1.5.0.1

- Fix admin user creation: call POST /api/users/adm/createsuperadmin after server starts
- Add curl to container for admin API setup

## 1.5.0

- Update Netmaker server to v1.5.0

## 0.99.0.1

- Fix MQ broker config: use SERVER_BROKER_ENDPOINT env var instead of MQ_HOST/MQ_PORT
- Replace mq_host, mq_port, mq_use_tls options with single mq_broker_endpoint URL

## 0.24.2

- Add Netmaker Controller add-on for Home Assistant
- Support SQLite persistence at /data/netmaker.db
- Auto-generate master key, admin password, and MQTT password if not provided
- Configure via HA UI with domain, MQTT broker, and security settings
