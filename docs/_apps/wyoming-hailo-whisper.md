---
name: wyoming-hailo-whisper
title: Wyoming Hailo Whisper
description: "Local Whisper STT for Home Assistant using Hailo-8 / Hailo-8L on Raspberry Pi 5 over the Wyoming protocol."
category: AI & Machine Learning
version: 0.0.2
architectures:
  - aarch64
ports:
  - 10600
faq:
  - q: "Why does the app exit immediately on startup?"
    a: "The Hailo Python wheel is probably missing. Place the required wheel into /share/wyoming-hailo-whisper/hailo_packages/ and start the app again."
  - q: "Does the app download the Hailo runtime by itself?"
    a: "No. The Hailo Python runtime wheel must be provided manually. The app only auto-downloads public Whisper model resources."
---

# Wyoming Hailo Whisper

Local Wyoming speech-to-text app for **Home Assistant** using **Whisper accelerated by Hailo-8 / Hailo-8L** on **Raspberry Pi 5**.

## About

This app exposes a Wyoming STT endpoint on port `10600`, intended for Home Assistant voice pipelines. It uses persistent storage under `/share/wyoming-hailo-whisper/` for runtime packages and model resources.

## What is stored in `/share`

- `/share/wyoming-hailo-whisper/hailo_packages/` — manually provided Hailo Python wheel
- `/share/wyoming-hailo-whisper/models/` — downloaded HEF/model assets

## Installation

1. Add the J0rsa repository to Home Assistant
2. Install **Wyoming Hailo Whisper**
3. Place the required Hailo Python wheel into:
   - `/share/wyoming-hailo-whisper/hailo_packages/`
4. Start the app
5. Add a Wyoming integration in Home Assistant pointing to port `10600`

## Configuration

### Variant
Supported model variants:
- `tiny`
- `base`

### Device
Supported Hailo devices:
- `hailo8`
- `hailo8l`

### Language
Supported configured languages:
- `en`
- `ru`

## Notes

- The Hailo Python runtime wheel is **manual** by design
- Public Whisper resources are downloaded automatically when needed
- This app is currently **aarch64 / Raspberry Pi 5 focused**

## Upstream references

- [Upstream project](https://github.com/mpeex/wyoming-hailo-whisper)
- [Hailo community thread](https://community.hailo.ai/t/whisper-home-assistant-integration/15535)

---

[← Back to Apps](/apps/) | [View on GitHub](https://github.com/j0rsa/home-assistant-apps/tree/main/wyoming-hailo-whisper)
