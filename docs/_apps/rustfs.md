---
name: rustfs
title: RustFS - S3-Compatible Object Storage
description: "High-performance S3-compatible object storage for Home Assistant. MinIO alternative with web console and optional OpenID Connect SSO."
category: Backup & Storage
version: latest
architectures:
  - amd64
  - aarch64
ports:
  - 9000
  - 9001
faq:
  - q: "What credentials do I use to log in?"
    a: "Use the access_key and secret_key from the app options. Change the default secret before exposing the S3 API or console."
  - q: "Where is object data stored?"
    a: "By default under /share/rustfs. Set volumes to another path such as /data if you prefer the app data partition."
  - q: "How do I enable SSO?"
    a: "Set oidc_enable to true and fill oidc_config_url, oidc_client_id, and oidc_client_secret. Register the redirect URI ending in /rustfs/admin/v3/oidc/callback/default on your IdP."
  - q: "Open Web UI shows 404?"
    a: "Ingress is disabled — open http://homeassistant.local:9001/rustfs/console/ directly. The console is not served at / and is not Home Assistant Ingress compatible."
---

# RustFS

[RustFS](https://rustfs.com/) is a high-performance, distributed object storage system written in Rust. It is 100% S3-compatible and serves as a self-hosted MinIO alternative with a built-in web console.

## Features

- S3-compatible API for backups, media, and app data
- Web console for buckets, users, and access keys
- Root credentials plus full IAM (users, groups, policies, STS)
- Optional OpenID Connect SSO (Keycloak, Authentik, Entra ID, Authing, etc.)
- Access to Home Assistant folders: app config, HA config, share, and media

## Installation

1. Add the J0rsa repository to Home Assistant
2. Install **RustFS** from the App Store
3. Set a strong `secret_key` in the options
4. Start the app

## Access

| Endpoint | URL |
|----------|-----|
| S3 API | `http://homeassistant.local:9000` |
| Web console | `http://homeassistant.local:9001/rustfs/console/` |
| Health | `http://homeassistant.local:9000/health` |

Authenticate S3 clients with your configured `access_key` / `secret_key`. Use path-style addressing unless you set `server_domains`.

## Configuration

Example options:

```yaml
access_key: rustfsadmin
secret_key: "replace-with-a-long-random-secret"
volumes: /share/rustfs
console_enable: true
region: us-east-1
server_domains: ""
browser_redirect_url: ""
cors_allowed_origins: "*"
log_level: info
oidc_enable: false
oidc_config_url: ""
oidc_client_id: ""
oidc_client_secret: ""
oidc_scopes: openid,profile,email
oidc_display_name: SSO
oidc_redirect_uri: ""
oidc_redirect_uri_dynamic: false
oidc_groups_claim: groups
oidc_roles_claim: ""
oidc_role_policy: ""
oidc_email_claim: email
oidc_username_claim: preferred_username
```

### Auth (root credentials)

`access_key` and `secret_key` are the root owner credentials. They bypass IAM policies — use them for bootstrap, then create IAM users or service accounts from the console for day-to-day access.

### SSO (OpenID Connect)

Set `oidc_enable: true` and provide at least:

- `oidc_config_url` — IdP discovery URL (`…/.well-known/openid-configuration`)
- `oidc_client_id` / `oidc_client_secret`
- `browser_redirect_url` — public URL of the console (helps OIDC redirects)
- `oidc_redirect_uri` — typically `https://<host>:9001/rustfs/admin/v3/oidc/callback/default`

Optional claim mapping:

- `oidc_groups_claim` / `oidc_roles_claim` — matched against RustFS policy names
- `oidc_role_policy` — blanket policy for every user from this IdP (e.g. `consoleAdmin`)

Supported IdPs include Keycloak, Authentik, Microsoft Entra ID, Authing, and other standard OIDC providers.

### Mapped folders

| Path in container | Source |
|-------------------|--------|
| `/config` | App public config (`addon_config`) |
| `/homeassistant` | Home Assistant configuration |
| `/share` | Shared folder |
| `/media` | Media folder |
| `/ssl` | TLS certificates (read-only) |
| `/data` | Persistent app data |
| `/share/rustfs` | Default object store path (`volumes`) |

## Security

- Change the default `secret_key` before opening ports outside your LAN
- Prefer SSO + IAM users over sharing the root secret
- Keep the S3 API (9000) off the public internet unless fronted by TLS and tight ACLs
- Do not point `volumes` at `/homeassistant` unless you intentionally want the config tree as the object store disk

## Support

- Upstream docs: [https://docs.rustfs.com/](https://docs.rustfs.com/)
- App repository: [https://github.com/j0rsa/home-assistant-apps](https://github.com/j0rsa/home-assistant-apps)
