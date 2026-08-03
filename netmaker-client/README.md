# Netmaker Client App

![](logo.png)

Official Netmaker WireGuard client for Home Assistant. Joins a Netmaker mesh network as a plain peer.

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]

## About

This app runs the official Netmaker `netclient` to connect Home Assistant to your Netmaker-managed WireGuard mesh. It performs enrollment and keeps the daemon running so peer config stays in sync.

## Configuration

### Required Settings

#### Option: `host_name`
Device name shown in the Netmaker network.
- Default: `homeassistant-netmaker`

#### Option: `netclient_token`
Enrollment token from your Netmaker dashboard (enrollment key).

### Optional Settings

#### Option: `debug_mode`
Log routing table and interfaces after join.
- Default: `false`

#### Option: `auto_restart`
Restart join/daemon if the process exits.
- Default: `true`

## Example Configuration

```yaml
host_name: "homeassistant-netmaker"
netclient_token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.your_actual_token_here"
debug_mode: false
auto_restart: true
```

## Setup Instructions

1. Ensure your Netmaker server/API is reachable over HTTPS (e.g. Cloudflare Tunnel)
2. Create an enrollment key in the Netmaker dashboard
3. Set `host_name` and `netclient_token` in the app options
4. Start the app — it joins the network and runs `netclient daemon`

## How It Works

1. `netclient join` enrolls this host with the controller
2. `netclient daemon` maintains WireGuard peers and MQTT signaling
3. Mesh traffic follows Netmaker network policy (no local SOCKS redirection)

## Troubleshooting

### Enable Debug Mode
Set `debug_mode: true` for extra interface/route logging after join.

### Common Issues

- **"Netclient token is required"**: Provide a valid enrollment token
- **"Failed to join network"**: Verify the token and that `https://<nm_domain>` is reachable from HA
- **EOF / connection errors on join**: Confirm Cloudflare Tunnel (or reverse proxy) is healthy; this app no longer routes API traffic through SOCKS

### Network Requirements

- Host networking (`host_network: true`)
- `NET_ADMIN` capability
- Access to `/dev/net/tun`
- Outbound HTTPS to your Netmaker API
- Outbound connectivity to the MQ broker used by the controller

## Support

For issues and feature requests, please visit the [GitHub repository](https://github.com/j0rsa/home-assistant-apps).

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
