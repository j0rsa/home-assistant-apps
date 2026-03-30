# Netmaker Dashboard UI App

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]

## About

Web dashboard for managing Netmaker mesh networks. This stateless React SPA communicates with the Netmaker Controller API over HTTPS to manage networks, nodes, users, and policies.

- **Network management** — create and configure mesh networks
- **Node management** — view, approve, and remove peers
- **User & ACL management** — control access to networks
- **HA sidebar integration** — accessible via ingress

## Configuration

### Optional Settings

| Option | Description | Default |
|--------|-------------|---------|
| `backend_url` | Full URL of the Netmaker Controller API (e.g., `https://api.netmaker.example.com`) | UI default |

If `backend_url` is left blank, the UI uses its built-in default endpoint.

### Example Configuration

```yaml
backend_url: "https://api.netmaker.example.com"
```

## Prerequisites

1. **Netmaker Controller** add-on installed and running
2. Controller API reachable from the browser (via Cloudflare Tunnel or reverse proxy)

## Ports

| Port | Protocol | Use |
|------|----------|-----|
| 80 (→ 8082) | TCP/HTTP | Dashboard UI |

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

## Support

- [GitHub Issues](https://github.com/j0rsa/home-assistant-apps/issues)
- [Netmaker Documentation](https://docs.netmaker.io/)

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
