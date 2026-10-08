---
name: borg
title: Borg - BorgBackup with Web UI
description: "BorgBackup engine with a web interface — create encrypted deduplicated backups and manage them from the browser."
category: Backup & Storage
version: latest
architectures:
  - amd64
  - aarch64
ports: []
faq:
  - q: "Do I need a separate login?"
    a: "No. Borg opens through the Home Assistant ingress panel. HA handles authentication — no separate credentials required."
  - q: "Where should I store my Borg repositories?"
    a: "Create repositories at local paths like /share/borg-repos/my-repo to keep them on the HA host under the share folder."
  - q: "What folders can I back up?"
    a: "Borg can see /share, /backup, and /media (read-only). Add those paths as source folders when configuring a backup job."
  - q: "Which Borg versions are included?"
    a: "The image bundles both borg (BorgBackup 1.x) and borg2 (BorgBackup 2.x). You can create repositories for either version."
---

# Borg

[Borg](https://borgui.com) bundles the [BorgBackup](https://www.borgbackup.org/) engine (both 1.x and 2.x) with a web interface. Create encrypted, deduplicated backups and manage repositories, archives, and restores from the browser — no terminal required.

## Features

- Full BorgBackup engine — `borg` (1.x) and `borg2` (2.x) both included
- Browse archives and restore individual files from the browser
- Create and manage local or SSH-backed repositories
- Schedule automated backups with configurable pre/post hooks
- Access HA's share, backup, and media folders as backup sources
- Ingress support — opens inside the HA sidebar, no extra port or login

## Installation

1. Add the J0rsa repository to Home Assistant
2. Install **Borg UI**
3. Start the app

Borg UI opens directly in the Home Assistant sidebar via ingress. No separate login is required — HA handles authentication.

## Backup Sources

The following Home Assistant directories are accessible inside Borg UI:

| Path | Content |
|------|---------|
| `/share` | HA shared folder |
| `/backup` | HA backup snapshots |
| `/media` | HA media folder (read-only) |

To create a repository on the HA host, use a path like `/share/borg-repos/my-repo` in Borg UI's repository setup.

## SSH Repositories

You can also connect to remote Borg repositories over SSH. Borg UI manages SSH keys internally — generate or import a key from the Settings page, then authorise it on your remote server.

## Persistent Data

App state (SQLite database, SSH keys, Borg keyfiles) is stored in the app's private config volume and persists across restarts and updates.

## Support

- Upstream project: [https://borgui.com](https://borgui.com)
- App repository: [https://github.com/j0rsa/home-assistant-apps](https://github.com/j0rsa/home-assistant-apps)
