---
name: vk-turn-proxy
title: VK TURN Proxy
description: "Server-side TURN-based proxy for tunneling traffic through VK calls."
category: Networking
version: 1.8.2
architectures:
  - amd64
  - aarch64
ports:
  - 56000
faq:
  - q: "What should I put into connect_addr?"
    a: "Set the backend target as host:port, for example 127.0.0.1:51820 for a local WireGuard instance."
  - q: "What is vless_mode?"
    a: "Enable it only when you want the proxy to forward TCP/VLESS-style traffic instead of the default UDP/WireGuard-style mode."
---

# VK TURN Proxy

Server-side wrapper for [`vk-turn-proxy`](https://github.com/cacggghp/vk-turn-proxy) packaged for the `home-assistant-apps` repository.

## About

This app exposes UDP port `56000` and forwards incoming traffic to a configured backend address. It is intended for advanced networking scenarios using the upstream `vk-turn-proxy` project.

## Configuration

### connect_addr
Required backend target in `host:port` form.

Examples:
- `127.0.0.1:51820`
- `192.168.1.10:51820`

### vless_mode
Optional boolean flag to enable VLESS-style forwarding mode.

## Port

- `56000/udp`

## Upstream

- [Repository](https://github.com/cacggghp/vk-turn-proxy)
- [Container package](https://github.com/cacggghp/vk-turn-proxy/pkgs/container/vk-turn-proxy)

---

[← Back to Apps](/apps/) | [View on GitHub](https://github.com/j0rsa/home-assistant-apps/tree/main/vk-turn-proxy)
