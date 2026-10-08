# Borg

[Borg](https://borgui.com) is a web interface for [BorgBackup](https://www.borgbackup.org/). Browse archives, manage repositories, and restore individual files from your browser — no terminal required.

## Features

- Browse BorgBackup archives and restore files via the web UI
- Create and manage local or SSH-backed repositories
- Schedule automated backups with pre/post hooks
- Access Home Assistant's share, backup, and media folders as backup sources
- Ingress support — opens inside the HA sidebar, no extra port or login required

## Installation

1. Add the J0rsa repository to Home Assistant
2. Install **Borg**
3. Start the app — it opens via the HA sidebar (no extra credentials needed)

## Access

Borg opens through the Home Assistant ingress panel. HA handles authentication so no separate login is required.

## Backup Sources

The following Home Assistant folders are available as local mount points inside Borg:

| Path in Borg | Content |
|-----------------|---------|
| `/share` | HA share folder |
| `/backup` | HA backup snapshots |
| `/media` | HA media folder (read-only) |

Create repositories at local paths like `/share/borg-repos/my-repo` to keep backups on the HA host.

## Persistent Data

App state (database, SSH keys, Borg keyfiles) is stored under the app's private config directory and survives restarts and updates.

## Support

- Upstream project: [https://borgui.com](https://borgui.com)
- App repository: [https://github.com/j0rsa/home-assistant-apps](https://github.com/j0rsa/home-assistant-apps)
