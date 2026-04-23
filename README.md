# Disk Sweeper

Cache and junk file cleaner for macOS.

## Scripts

| Script | Description |
|--------|-------------|
| `scan.sh` | Scan all user-level caches (overview) |
| `scan-app.sh <app>` | Scan cache for a specific app |
| `clean-app.sh <app>` | Clean cache for a specific app |
| `clean-all.sh` | Clean ALL caches (requires `YES`) |
| `deep-scan.sh` | Find large files (>100MB) in home dir |
| `list-apps.sh` | List all supported apps |

## Quick Start

```bash
cd ~/skill/disk-sweeper

# Scan everything
./scan.sh

# Scan specific app
./scan-app.sh chrome
./scan-app.sh vscode xcode

# Clean specific app
./clean-app.sh chrome

# Clean multiple apps
./clean-app.sh chrome vscode npm

# Deep scan for large files
./deep-scan.sh
```

## Supported Apps

| App | Command |
|-----|---------|
| Google Chrome | `chrome` |
| Mozilla Firefox | `firefox` |
| Apple Safari | `safari` |
| Visual Studio Code | `vscode` |
| Cursor | `cursor` |
| Apple Xcode | `xcode` |
| JetBrains IDEs | `jetbrains` |
| Anaconda | `anaconda` |
| Homebrew | `homebrew` |
| pip | `pip` |
| npm | `npm` |
| conda | `conda` |
| Docker | `docker` |
| Slack | `slack` |
| Discord | `discord` |
| Zoom | `zoom` |
| WeChat | `wechat` |
| Spotify | `spotify` |
| Unity | `unity` |
| Blender | `blender` |
| Adobe | `adobe` |
| MATLAB | `matlab` |
| GitHub Desktop | `github-desktop` |

## Safety Rules

- **Scan first, ask second, clean third**
- Always close the app before cleaning its cache
- Never clean `.Trash` unless explicitly asked
- Xcode DerivedData and JetBrains caches will rebuild (takes time)
- System caches (`/Library/Caches/`) require `sudo` — be cautious
