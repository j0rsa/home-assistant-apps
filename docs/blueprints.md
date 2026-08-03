---
title: Automation Blueprints
description: "Ready-to-use Home Assistant automation blueprints, including an ESPHome auto-updater."
permalink: /blueprints/
---

# Automation Blueprints

Ready-to-use Home Assistant automation blueprints for common smart home tasks.

## Available Blueprints

### ESPHome Auto-Updater

Automatically compile and update selected ESPHome devices when new versions are available.

**Features:**
- 🔄 **Auto Updates**: Automatically update ESPHome devices
- ⏰ **Update Window**: Configure time window for updates (e.g., 2:00 AM - 6:00 AM)
- 📱 **Notifications**: Get notified before and after updates
- 🎯 **Selective Updates**: Choose which devices to auto-update
- ⏱️ **Delay Control**: Configure delay between updating multiple devices
- 🔔 **Flexible Notifications**: Use mobile app or persistent notifications

**Configuration Options:**
- `update_entities`: Select ESPHome update entities to monitor
- `update_time_start`: Start of update window (default: 02:00)
- `update_time_end`: End of update window (default: 06:00)
- `enable_time_window`: Only update within time window
- `notify_before_update`: Send notification before starting
- `notification_service`: Custom notification service
- `update_delay`: Seconds between device updates

**Import:**

[![Open your Home Assistant instance and show the blueprint import dialog with a specific blueprint pre-filled.](https://my.home-assistant.io/badges/blueprint_import.svg)](https://my.home-assistant.io/redirect/blueprint_import/?blueprint_url=https%3A%2F%2Fgithub.com%2Fj0rsa%2Fhome-assistant-apps%2Fblob%2Fmain%2Fblueprints%2Fesphome_auto_updater.yaml)

**Manual Import URL:**
```
https://github.com/j0rsa/home-assistant-apps/blob/main/blueprints/esphome_auto_updater.yaml
```

[View Blueprint YAML](https://github.com/j0rsa/home-assistant-apps/blob/main/blueprints/esphome_auto_updater.yaml)

---

## How to Import Blueprints

### Method 1: One-Click Import

Click the "Import Blueprint" button above for any blueprint. This will:
1. Open your Home Assistant instance
2. Pre-fill the blueprint URL
3. Show the import dialog

### Method 2: Manual Import

1. Go to **Settings** → **Automations & Scenes** → **Blueprints**
2. Click **Import Blueprint**
3. Paste the blueprint URL
4. Click **Preview** then **Import**

## Using Blueprints

After importing:

1. Go to **Settings** → **Automations & Scenes**
2. Click **Create Automation**
3. Select **Use a Blueprint**
4. Find and select the imported blueprint
5. Configure the options
6. Save the automation

## Support

- [GitHub Issues](https://github.com/j0rsa/home-assistant-apps/issues)
- [Home Assistant Blueprints Documentation](https://www.home-assistant.io/docs/automation/using_blueprints/)

---

[← Back to Home](/) | [View on GitHub](https://github.com/j0rsa/home-assistant-apps/tree/main/blueprints)
