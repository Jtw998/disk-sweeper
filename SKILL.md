---
name: disk-sweeper
description: Scan and clean cache/junk files on macOS. Use when user asks to clean caches, check disk usage, remove junk files, find large files, free up disk space, or clean cache for a specific app.
tools: Bash
---

# Disk Sweeper

A cache and junk file cleaner for macOS.

## Scripts

| Script | Purpose |
|--------|---------|
| `./scan.sh` | Scan all caches (overview) |
| `./scan-app.sh <app>` | Scan cache for a specific app |
| `./clean-app.sh <app>` | Clean cache for a specific app |
| `./clean-all.sh` | Clean ALL caches (requires `YES` confirmation) |
| `./deep-scan.sh` | Find large files (>100MB) |
| `./list-apps.sh` | List all supported apps |

## Supported Apps

```
chrome, firefox, safari
vscode, cursor, xcode
jetbrains (IntelliJ, PyCharm, GoLand, WebStorm, CLion)
anaconda
homebrew, pip, npm, conda, docker
slack, discord, zoom, wechat
spotify, unity, blender, adobe, matlab, github-desktop
```

## Safety Rules

- **Scan first, ask second, clean third**
- `~/Library/Caches/` — generally safe
- `~/Library/Logs/` — safe, but warn if user is debugging
- `/Library/Caches/` — system caches, needs `sudo`, be cautious
- Xcode DerivedData — safe if not developing, but rebuilds take time
- Docker `docker system prune` — only removes unused resources, safe
- conda/pip/npm caches — safe to clean at any time
- **Never clean while the app is running** — warn user to quit first
- Never clean `.Trash` unless user explicitly asks
- JetBrains caches trigger re-index — warn user
