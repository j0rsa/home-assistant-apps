---
name: netmaker-controller
title: Netmaker Controller - Mesh Network Orchestrator
description: "WireGuard mesh network controller for Home Assistant. Control-plane-only orchestrator with SQLite persistence and external MQ broker support."
category: Networking & Proxy
version: latest
architectures:
  - amd64
  - aarch64
ports:
  - 8081
  - 50051
---

# Netmaker Controller App

WireGuard mesh network controller and orchestrator for Home Assistant. Runs as control plane only — no WireGuard endpoints on the HA host.

## About

This app runs the Netmaker server (API + gRPC) as a containerized HA add-on. It serves as the single source of truth for mesh topology, node state, and network policies. All VPN traffic flows directly between peers; the HA host only orchestrates.

## Features

- **Control plane only** — no WireGuard interfaces or UDP ports on HA
- **Persistent state** — SQLite database backed up with HA add-on backups
- **External MQTT** — connects to your MQ broker for real-time peer signaling
- **Auto-generated secrets** — master key, admin password, and MQ password generated if not provided
- **Multi-arch** — supports amd64 and aarch64

## Installation

1. Add the J0rsa repository to your Home Assistant
2. Search for "Netmaker Controller" in the App Store
3. Click Install and wait for the download to complete
4. Configure domain and MQ broker settings
5. Start the app

## Configuration

### Required Settings

| Option | Description |
|--------|-------------|
| `nm_domain` | Base domain for API/dashboard (e.g., `netmaker.example.com`) |

### MQTT Client Settings (controller connects TO external MQ broker)

| Option | Description | Default |
|--------|-------------|---------|
| `mq_host` | Hostname of external MQ broker | `mqtt.netmaker.example.com` |
| `mq_port` | Port on MQ broker to connect to | `1883` |
| `mq_username` | Username for authenticating to MQ broker | `netmaker` |
| `mq_password` | Password for authenticating to MQ broker (auto-generated if blank) | auto |
| `mq_use_tls` | Use TLS when connecting to MQ broker | `false` |

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

## Example Configuration

```yaml
nm_domain: "netmaker.example.com"
mq_host: "mqtt.netmaker.example.com"
mq_port: 1883
mq_username: "netmaker"
mq_password: "your-mqtt-password"
master_key: "your-master-key"
verbosity: 1
```

## Prerequisites

1. **Cloudflare Tunnel** (or reverse proxy) routing `api.netmaker.example.com:443` → HA `localhost:8081`
2. **External MQ broker** (e.g., EMQX, Mosquitto) reachable from HA and WAN peers
3. **Domain** configured with DNS records pointing to the tunnel

## How It Works

```
Peer → HTTPS (Cloudflare Tunnel) → Controller API (:8081)
                                  → gRPC (:50051)
                                  → MQTT (MQ Broker) → Peers
```

1. Peers join via the Controller API using enrollment tokens
2. Controller assigns IPs and distributes peer lists
3. Topology changes are published to the MQ broker
4. Peers form direct WireGuard tunnels to each other (UDP, peer-to-peer)
5. HA host never carries VPN traffic

## Security

- **Master key** protects API access — store securely
- **MQTT credentials** restrict topic access to `netmaker/#`
- **No WireGuard** on HA host — zero attack surface for VPN traffic
- **Cloudflare Tunnel** provides TLS termination

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

---

[← Back to Apps](/apps/) | [View on GitHub](https://github.com/j0rsa/home-assistant-apps/tree/main/netmaker-controller)
