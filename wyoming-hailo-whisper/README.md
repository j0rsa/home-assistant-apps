# Wyoming Hailo Whisper

Wyoming speech-to-text app for Home Assistant using Whisper accelerated by **Hailo-8 / Hailo-8L** on **Raspberry Pi 5**.

This app is based on the upstream project [`mpeex/wyoming-hailo-whisper`](https://github.com/mpeex/wyoming-hailo-whisper), but adapted to fit the structure and conventions of the `home-assistant-apps` repository.

## What this app does

- exposes a Wyoming STT endpoint on port **10600**
- runs locally on **aarch64 / Raspberry Pi 5**
- uses **Hailo hardware acceleration** for Whisper inference
- stores runtime files and downloaded model assets in `/share/wyoming-hailo-whisper`

## Current v1 scope

- supported devices:
  - `hailo8`
  - `hailo8l`
- supported Whisper variants:
  - `tiny`
  - `base`
- supported configured languages:
  - `en`
  - `ru`

## Persistent folders

The app uses these folders under `/share/wyoming-hailo-whisper/`:

- `hailo_packages/` — manually supplied Hailo Python runtime wheel
- `models/` — downloaded Whisper HEFs and decoder assets

## Hailo runtime setup

The Hailo runtime is **not** downloaded automatically.

Before starting the app, place the required Hailo Python wheel into:

`/share/wyoming-hailo-whisper/hailo_packages/`

For v1, the app expects the **Python wheel (`.whl`) only**.

If the wheel is missing, the app will log clear instructions and exit.

## Model resources

Whisper model resources are handled separately from the runtime.

If missing, the app will automatically download the required public assets into:

`/share/wyoming-hailo-whisper/models/`

This includes:
- HEF files
- decoder assets

## Home Assistant usage

After starting the app:
1. Open Home Assistant
2. Add a **Wyoming** speech-to-text integration
3. Point it to the machine running this app on port `10600`
4. Use it in your voice pipeline

## Configuration

### `variant`
Whisper model variant:
- `tiny`
- `base`

### `device`
Target hardware:
- `hailo8`
- `hailo8l`

### `language`
Configured language:
- `en`
- `ru`

## Known limitations

- currently **aarch64 only**
- expects **`/dev/hailo0`** to exist
- runtime wheel setup is manual
- only `tiny` and `base` are exposed for now
- language selection for v1 is limited to `en` and `ru`

## Upstream references

- <https://github.com/mpeex/wyoming-hailo-whisper>
- <https://community.hailo.ai/t/whisper-home-assistant-integration/15535>
