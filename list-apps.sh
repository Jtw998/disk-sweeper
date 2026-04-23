#!/bin/bash
# disk-sweeper/list-apps.sh — List all supported apps

echo "=========================================="
echo "    Disk Sweeper — Supported Apps"
echo "=========================================="
echo ""

cat << 'EOF'
Browsers
  chrome      — Google Chrome
  firefox     — Mozilla Firefox
  safari      — Apple Safari

Editors / IDEs
  vscode      — Visual Studio Code
  cursor      — Cursor (VS Code fork)
  xcode       — Apple Xcode
  jetbrains   — JetBrains family
               (IntelliJ, PyCharm, GoLand, WebStorm, CLion)
  anaconda    — Anaconda / conda

Dev Tools
  homebrew    — Homebrew
  pip         — pip / Python
  npm         — npm / Node.js
  conda       — conda / Python env
  docker      — Docker

Communication
  slack       — Slack
  discord     — Discord
  zoom        — Zoom
  wechat      — WeChat

Other
  spotify     — Spotify
  unity       — Unity
  blender     — Blender
  adobe       — Adobe (Creative Cloud)
  matlab      — MATLAB
  github-desktop — GitHub Desktop

Usage:
  ./scan-app.sh <app>    — show cache for app
  ./clean-app.sh <app>   — clean cache for app
EOF
echo ""
echo "Run ./scan.sh for full cache overview"
