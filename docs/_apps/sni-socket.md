---
name: sni-socket
title: SNI Socket Proxy - SOCKS5 Routing
description: "SNI proxy with SOCKS5 support for Home Assistant. Routes HTTP and HTTPS traffic through a SOCKS5 proxy based on hostname matching using SNI and Host headers."
category: Networking & Proxy
version: 1.1.0
architectures:
  - amd64
  - aarch64
ports:
  - 80
  - 443
faq:
  - q: "How does SNI Socket Proxy differ from SNI Proxy?"
    a: "SNI Socket Proxy routes all matched traffic through a SOCKS5 proxy before forwarding to the destination, while SNI Proxy forwards directly. Use SNI Socket when you need an extra proxy layer."
  - q: "Why is my SNI Socket Proxy connection failing?"
    a: "Verify the SOCKS5 proxy address and port are correct and accessible from the app container. Check the app logs for detailed error messages and ensure ports 80 and 443 are not used by another service."
---

# SNI Socket Proxy App

SNI Socket Proxy routes HTTP and HTTPS traffic through a SOCKS5 proxy based on hostname matching. It uses SNI for HTTPS and the Host header for HTTP to determine routing, forwarding all traffic via a configured SOCKS5 upstream.

## Features

- 🔀 **SOCKS5 Routing**: Routes all matched traffic through a SOCKS5 proxy
- 🔧 **Simple Configuration**: Just set SOCKS5 address and port
- 📡 **Dual Port**: Listens on ports 80 (HTTP) and 443 (HTTPS)
- 🛡️ **Proxychains Backend**: Uses proxychains for reliable SOCKS5 forwarding
- 🔒 **SSL Passthrough**: HTTPS traffic passes through without decryption

## Use Cases

- Route specific HTTP/HTTPS traffic through a VPN, Tor, or other SOCKS5 proxy
- Transparent hostname-based proxying with an extra privacy layer
- Combine with [Go SOCKS5 Proxy](/apps/go-socks5-proxy/) or [Xray](/apps/xray/) for layered routing

## Installation

1. Add the J0rsa repository to your Home Assistant
2. Search for "SNI Socket Proxy" in the App Store (formerly Add-on Store)
3. Click Install and wait for the download to complete
4. Configure the SOCKS5 proxy settings
5. Start the app

## Configuration

```yaml
socks5_address: "192.168.1.100"  # SOCKS5 proxy server address
socks5_port: 1080                # SOCKS5 proxy server port
```

### Configuration Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `socks5_address` | String | `""` | SOCKS5 proxy server address (IP or hostname) |
| `socks5_port` | Integer | `1080` | SOCKS5 proxy server port (1-65535) |

## How It Works

1. The app listens on ports 80 (HTTP) and 443 (HTTPS) for incoming connections
2. For HTTPS: extracts the SNI hostname from the TLS Client Hello
3. For HTTP: extracts the hostname from the Host header
4. All traffic is routed through the configured SOCKS5 proxy
5. The SOCKS5 proxy forwards traffic to the destination server

```
Client → SNI Socket Proxy (443) → [reads SNI] → SOCKS5 Proxy → Destination
```

## Ports

| Port | Protocol | Description |
|------|----------|-------------|
| 80 | TCP | HTTP proxy port |
| 443 | TCP | HTTPS/SSL proxy port |

## Integration with Other Apps

This app works well with:

- [Go SOCKS5 Proxy](/apps/go-socks5-proxy/) — use as the SOCKS5 upstream
- [Xray](/apps/xray/) — route traffic through Xray's SOCKS5 proxy
- [SNI Proxy](/apps/sniproxy/) — similar but without SOCKS5 routing

## Troubleshooting

### Connection Issues
- Verify the SOCKS5 proxy address and port are correct and accessible
- Ensure the SOCKS5 proxy server is running

### Port Conflicts
- Ensure ports 80 and 443 are not used by another service
- Check the app logs for detailed error messages

### SOCKS5 Proxy Unreachable
- Confirm the SOCKS5 proxy is accessible from the app container's network
- Check firewall rules between the app and the SOCKS5 server

## Support

- [GitHub Issues](https://github.com/j0rsa/home-assistant-apps/issues)

---

[← Back to Apps](/apps/) | [View on GitHub](https://github.com/j0rsa/home-assistant-apps/tree/main/sni-socket)
