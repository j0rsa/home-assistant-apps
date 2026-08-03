---
name: netmaker-client
title: Netmaker Client - VPN Client
description: "Official Netmaker WireGuard client for Home Assistant. Joins a mesh network as a plain peer with auto-restart and debug support."
category: Networking & Proxy
version: latest
architectures:
  - amd64
  - aarch64
ports: []
---

# Netmaker Client App

Official Netmaker WireGuard client for Home Assistant. Joins a Netmaker mesh network as a plain peer.

## About

This app runs the official Netmaker `netclient` to connect Home Assistant to your Netmaker-managed WireGuard mesh. It enrolls with your controller and keeps the daemon running so peer configuration stays in sync.

## Features

- WireGuard mesh connectivity via Netmaker
- Official `netclient` join + daemon
- Automatic restart on failure
- Debug logging for interfaces and routes

## Installation

1. Add the J0rsa repository to your Home Assistant
2. Search for "Netmaker Client" in the App Store
3. Click Install and wait for the download to complete
4. Configure your Netmaker enrollment token
5. Start the app

## Configuration

### Required Settings

| Option | Description |
|--------|-------------|
| `host_name` | Device name in Netmaker network (default: `homeassistant-netmaker`) |
| `netclient_token` | Enrollment token from Netmaker dashboard |

### Optional Settings

| Option | Description | Default |
|--------|-------------|--------|
| `debug_mode` | Log interfaces/routes after join | `false` |
| `auto_restart` | Auto restart on failure | `true` |

## Example Configuration

```yaml
host_name: "homeassistant-netmaker"
netclient_token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
debug_mode: false
auto_restart: true
```

## Setup Instructions

1. Ensure your Netmaker API is reachable over HTTPS (e.g. Cloudflare Tunnel)
2. Create an enrollment key in the Netmaker dashboard
3. Enter `host_name` and `netclient_token` in the app options
4. Start the app — it joins and runs `netclient daemon`

## How It Works

```
Home Assistant → netclient → Netmaker API (HTTPS) + MQTT
                           → WireGuard mesh peers
```

1. `netclient join` enrolls this host
2. `netclient daemon` maintains peers and signaling
3. Traffic follows Netmaker network policy (no local SOCKS redirection)

## Troubleshooting

### Enable Debug Mode

Set `debug_mode: true` for additional interface and route logging after join.

### Common Issues

| Issue | Solution |
|-------|----------|
| "Netclient token is required" | Provide a valid enrollment token |
| "Failed to join network" | Verify token and API HTTPS reachability |
| EOF / connection errors on join | Confirm Cloudflare Tunnel or reverse proxy is healthy |

### Network Requirements

- Host networking (`host_network: true`)
- `NET_ADMIN` capability
- Access to `/dev/net/tun`
- Outbound HTTPS to your Netmaker API
- Outbound connectivity to the MQ broker used by the controller

## Support

- [GitHub Issues](https://github.com/j0rsa/home-assistant-apps/issues)
- [Netmaker Documentation](https://docs.netmaker.io/)

---

[← Back to Apps](/apps/) | [View on GitHub](https://github.com/j0rsa/home-assistant-apps/tree/main/netmaker-client)
