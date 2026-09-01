# Changelog

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

## 1.6.0.1

- Update base image to Alpine 3.24

## 1.5.0

- Update Netmaker UI to v1.5.0

## 0.99.0.2

- Add nginx reverse proxy for API requests to Netmaker Controller backend

## 0.99.0.1

- Fix nginx config: generate SPA-compatible server block at runtime instead of copying upstream config
- Inject backend URL into served JS files when configured

## 0.24.2

- Add Netmaker Dashboard UI add-on for Home Assistant
- Serve React SPA via nginx with configurable backend API URL
- Support HA ingress for sidebar integration
