---
name: netmaker-ui
title: Netmaker Dashboard UI - Web Management Interface
description: "Web dashboard for managing Netmaker mesh networks, nodes, users, and policies from Home Assistant."
category: Networking & Proxy
version: latest
architectures:
  - amd64
  - aarch64
ports:
  - 8082
---

# Netmaker Dashboard UI App

Web dashboard for managing Netmaker mesh networks. Stateless React SPA that communicates with the Netmaker Controller API.

## About

This app serves the official Netmaker web dashboard for managing networks, nodes, users, and access policies. It's a stateless frontend — all data is stored and managed by the Netmaker Controller add-on.

## Features

- **Network management** — create, configure, and monitor mesh networks
- **Node management** — view, approve, and remove peers
- **User & ACL management** — control who can access which networks
- **HA sidebar integration** — accessible directly from the HA sidebar via ingress
- **Stateless** — no local data; all state lives in the Controller

## Installation

1. Add the J0rsa repository to your Home Assistant
2. Search for "Netmaker Dashboard UI" in the App Store
3. Click Install and wait for the download to complete
4. Optionally set the `backend_url` to your Controller API
5. Start the app

## Configuration

### Optional Settings

| Option | Description | Default |
|--------|-------------|---------|
| `backend_url` | Full URL of the Netmaker Controller API (e.g., `https://api.netmaker.example.com`) | UI default |

If `backend_url` is left blank, the UI uses its built-in default API endpoint.

## Example Configuration

```yaml
backend_url: "https://api.netmaker.example.com"
```

## Prerequisites

1. **Netmaker Controller** add-on installed and running
2. Controller API reachable from the browser (via Cloudflare Tunnel or reverse proxy)

## Access

- **Via HA sidebar** — appears automatically after install (ingress enabled)
- **Via Cloudflare Tunnel** — route `dashboard.netmaker.example.com:443` → HA `localhost:8082`
- **Direct** — `http://<ha-ip>:8082`

## Troubleshooting

| Issue | Check |
|-------|-------|
| Dashboard loads but API calls fail | Verify `backend_url` matches the Controller's public domain |
| Blank page | Check browser console for CORS or network errors |
| Login fails | Verify Controller is running and admin credentials are correct |
| 404 on API calls | Ensure Cloudflare Tunnel routes API traffic correctly |

## Support

- [GitHub Issues](https://github.com/j0rsa/home-assistant-apps/issues)
- [Netmaker Documentation](https://docs.netmaker.io/)

---

[← Back to Apps](/apps/) | [View on GitHub](https://github.com/j0rsa/home-assistant-apps/tree/main/netmaker-ui)
