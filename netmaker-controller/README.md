# Netmaker Controller App

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]

## About

WireGuard mesh network controller and orchestrator for Home Assistant. Runs as a **control-plane-only** service — no WireGuard endpoints are created on the HA host. Designed to run behind Cloudflare Tunnel with an external MQ broker for peer signaling.

- **Zero WireGuard exposure** on the HA host
- **Persistent state** via SQLite backed up with HA add-on backups
- **Peer-to-peer mesh** where VPN traffic flows directly between nodes
- **External MQTT** via MQ broker for real-time peer signaling

## Configuration

### Required Settings

| Option | Description |
|--------|-------------|
| `nm_domain` | Base domain for API/dashboard (e.g., `netmaker.example.com`) |

### MQTT Client Settings (controller connects TO external MQ broker)

| Option | Description | Default |
|--------|-------------|---------|
| `mq_broker_endpoint` | MQ broker endpoint URL (`ws://host:1883` or `wss://host:8883`) | `ws://core-mosquitto:1884` |
| `mq_username` | Username for authenticating to MQ broker | `netmaker` |
| `mq_password` | Password for authenticating to MQ broker (auto-generated if blank) | auto |

### Optional Settings

| Option | Description | Default |
|--------|-------------|---------|
| `server_host` | Public IP of HA host (auto-detected if blank) | auto |
| `master_key` | Admin API key (auto-generated if blank) | auto |
| `admin_user` | Admin username | `admin` |
| `admin_password` | Admin password (auto-generated if blank) | auto |
| `dns_mode` | Enable DNS management | `false` |
| `verbosity` | Log verbosity (1-3) | `1` |
| `telemetry` | Send usage telemetry | `true` |

### Example Configuration

```yaml
nm_domain: "netmaker.example.com"
mq_broker_endpoint: "ws://core-mosquitto:1884"
mq_username: "netmaker"
mq_password: "your-mqtt-password"
master_key: "your-master-key"
verbosity: 1
```

## Prerequisites

1. **Cloudflare Tunnel** (or reverse proxy) routing `api.netmaker.example.com:443` → HA `localhost:8081`
2. **External MQ broker** reachable from HA and from WAN peers
3. **Domain** configured with DNS records pointing to the tunnel

## Ports

| Port | Protocol | Use |
|------|----------|-----|
| 8081 | TCP/HTTP | Netmaker API |
| 50051 | TCP/gRPC | Netmaker gRPC (peer config sync) |

## Data Persistence

All state is stored in SQLite at `/data/netmaker.db`, backed up automatically with HA add-on backups. Auto-generated secrets are persisted in `/data/.generated_secrets`.

## Troubleshooting

| Issue | Check |
|-------|-------|
| Controller won't start | Logs for port conflicts, DB lock, permission errors |
| Peers can't reach API | DNS resolution, Cloudflare Tunnel routing, port 8081 |
| MQTT connection fails | MQ broker reachability, credentials, ACLs, firewall |
| Dashboard 404 on API | Verify `nm_domain` matches Tunnel hostname |

## Support

- [GitHub Issues](https://github.com/j0rsa/home-assistant-apps/issues)
- [Netmaker Documentation](https://docs.netmaker.io/)

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
