# VK TURN Proxy

Home Assistant app wrapper for [`cacggghp/vk-turn-proxy`](https://github.com/cacggghp/vk-turn-proxy).

## What this app is for

This app is for **tunneling traffic through TURN servers** used by VK calls.

In practical terms, it is meant for scenarios such as:
- tunneling **WireGuard** traffic
- tunneling **VLESS/Xray** traffic
- forwarding traffic through the upstream `vk-turn-proxy` server flow

This app wraps the **server-side** component and exposes UDP port `56000`.

## What it does

The app accepts incoming traffic on port `56000/udp` and forwards it to a configured backend target.

Typical backend examples:
- `127.0.0.1:51820` for local WireGuard
- `192.168.1.10:51820` for remote/local WireGuard on another host
- a TCP/VLESS-style backend when `vless_mode` is enabled

## Configuration

### `connect_addr`
Required backend address in the form:

`host:port`

Examples:
- `127.0.0.1:51820`
- `192.168.1.10:51820`

### `vless_mode`
If enabled, the proxy runs in VLESS-oriented TCP forwarding mode.
Leave disabled for the default UDP/WireGuard-style mode.

## Ports

- `56000/udp` — external proxy port

## Notes

- This app wraps the **server** binary, not the client tools
- You still need a compatible client side and a valid call-link workflow as described upstream
- The exact traffic behavior and anti-censorship properties come from the upstream project design

## Upstream project

- Repository: <https://github.com/cacggghp/vk-turn-proxy>
- Container image: <https://github.com/cacggghp/vk-turn-proxy/pkgs/container/vk-turn-proxy>
