#!/bin/bash
# disk-sweeper/scan-app.sh — Scan cache for a specific app
set -euo pipefail

if [[ -z "$1" ]]; then
    echo "Usage: $0 <app> [app2 ...]"
    echo "Apps: chrome firefox safari vscode cursor xcode homebrew pip npm conda docker jetbrains anaconda docker-desktop github-desktop slack discord spotify zoom wechat unity blender adobe matlab"
    exit 1
fi

APP="$1"

case "$APP" in
  chrome)
    echo "=== Google Chrome ==="
    p=$(du -sh ~/Library/Caches/Google/Chrome/ 2>/dev/null)
    echo "Cache: $p"
    p=$(du -sh ~/Library/Application\ Support/Google/Chrome/Default/Cache* 2>/dev/null)
    [[ -n "$p" ]] && echo "WebCache: $p"
    ;;

  firefox)
    echo "=== Firefox ==="
    du -sh ~/Library/Caches/Firefox/ 2>/dev/null
    du -sh ~/Library/Application\ Support/Firefox/Profiles/*/cache2/ 2>/dev/null
    ;;

  safari)
    echo "=== Safari ==="
    du -sh ~/Library/Caches/com.apple.Safari* 2>/dev/null
    du -sh ~/Library/Containers/com.apple.Safari/Data/Library/Caches/* 2>/dev/null
    ;;

  vscode)
    echo "=== VS Code ==="
    du -sh ~/Library/Application\ Support/Code/Cache/ 2>/dev/null
    du -sh ~/Library/Application\ Support/Code/CachedExtensionVSIXs/ 2>/dev/null
    du -sh ~/Library/Application\ Support/Code/CachedData/ 2>/dev/null
    du -sh ~/Library/Application\ Support/Code/CachedExtensions/ 2>/dev/null
    du -sh ~/Library/Application\ Support/Code/Crashpad/compressed/ 2>/dev/null
    ;;

  cursor)
    echo "=== Cursor ==="
    du -sh ~/Library/Application\ Support/Cursor/Cache/ 2>/dev/null
    du -sh ~/Library/Application\ Support/Cursor/CachedExtensionVSIXs/ 2>/dev/null
    du -sh ~/Library/Application\ Support/Cursor/CachedData/ 2>/dev/null
    ;;

  xcode)
    echo "=== Xcode ==="
    du -sh ~/Library/Developer/Xcode/DerivedData/ 2>/dev/null
    du -sh ~/Library/Developer/Xcode/Archives/ 2>/dev/null
    du -sh ~/Library/Caches/com.apple.dt.Xcode/ 2>/dev/null
    du -sh ~/Library/Developer/CoreSimulator/Caches/ 2>/dev/null
    ;;

  homebrew)
    echo "=== Homebrew ==="
    BREW_CACHE=$(brew --cache 2>/dev/null)
    du -sh "$BREW_CACHE" 2>/dev/null
    du -sh /usr/local/Cellar/ 2>/dev/null
    du -sh ~/Library/Caches/Homebrew/ 2>/dev/null
    ;;

  pip)
    echo "=== pip / Python ==="
    du -sh ~/Library/Caches/pip/ 2>/dev/null
    ;;

  npm)
    echo "=== npm ==="
    du -sh ~/Library/Caches/npm/ 2>/dev/null
    du -sh ~/.npm/_cacache/ 2>/dev/null
    ;;

  conda)
    echo "=== conda ==="
    du -sh ~/.conda/ 2>/dev/null
    du -sh ~/Library/Caches/conda/ 2>/dev/null
    ;;

  docker)
    echo "=== Docker ==="
    du -sh ~/Library/Containers/com.docker.docker/ 2>/dev/null
    echo ""
    docker system df 2>/dev/null || true
    ;;

  jetbrains|intellij|pycharm|goland|webstorm|clion)
    echo "=== JetBrains IDE ==="
    du -sh ~/Library/Caches/JetBrains/ 2>/dev/null
    du -sh ~/Library/Application\ Support/JetBrains/*/caches/ 2>/dev/null
    du -sh ~/Library/Application\ Support/JetBrains/Toolbox/ 2>/dev/null
    ;;

  anaconda)
    echo "=== Anaconda ==="
    du -sh ~/Library/Application\ Support/Anaconda3/ 2>/dev/null
    du -sh ~/.conda/ 2>/dev/null
    du -sh ~/Library/Application\ Support/Anaconda-Navigator/ 2>/dev/null
    ;;

  github-desktop)
    echo "=== GitHub Desktop ==="
    du -sh ~/Library/Caches/githubforMacOsX/ 2>/dev/null
    du -sh ~/Library/Application\ Support/GitHub\ Desktop/ 2>/dev/null
    ;;

  slack)
    echo "=== Slack ==="
    du -sh ~/Library/Caches/com.tinyspeck.slackmacgap/ 2>/dev/null
    du -sh ~/Library/Containers/com.tinyspeck.slackmacgap/Data/Library/Application\ Support/Slack/Cache 2>/dev/null
    du -sh ~/Library/Containers/com.tinyspeck.slackmacgap/Data/Library/Application\ Support/Slack/CachedData 2>/dev/null
    ;;

  discord)
    echo "=== Discord ==="
    du -sh ~/Library/Caches/com.hnc.Discord/ 2>/dev/null
    du -sh ~/Library/Application\ Support/discord/ 2>/dev/null
    ;;

  spotify)
    echo "=== Spotify ==="
    du -sh ~/Library/Caches/com.spotify.client/ 2>/dev/null
    du -sh ~/Library/Application\ Support/Spotify/ 2>/dev/null
    ;;

  zoom)
    echo "=== Zoom ==="
    du -sh ~/Library/Caches/zoomus/ 2>/dev/null
    du -sh ~/Library/Application\ Support/zoomus/ 2>/dev/null
    ;;

  wechat)
    echo "=== WeChat ==="
    du -sh ~/Library/Containers/com.tencent.xinWeChat/Data/Library/Caches 2>/dev/null
    du -sh ~/Library/Containers/com.tencent.xinWeChat/Data/Library/Application\ Support/com.tencent.xinWeChat/ 2>/dev/null
    ;;

  unity)
    echo "=== Unity ==="
    du -sh ~/Library/Caches/Unity/ 2>/dev/null
    du -sh ~/Library/Application\ Support/Unity/ 2>/dev/null
    du -sh ~/Library/Application\ Support/Unity/AssetServerCacheV4 2>/dev/null
    ;;

  blender)
    echo "=== Blender ==="
    du -sh ~/Library/Application\ Support/Blender/*/cache 2>/dev/null
    du -sh ~/Library/Application\ Support/Blender/*/config/cache 2>/dev/null
    ;;

  adobe)
    echo "=== Adobe ==="
    du -sh ~/Library/Caches/Adobe/ 2>/dev/null
    du -sh ~/Library/Application\ Support/Adobe/Common/Media\ Cache* 2>/dev/null
    du -sh ~/Library/Application\ Support/Adobe/Common/Adobe\ CrashReporter/ 2>/dev/null
    ;;

  matlab)
    echo "=== MATLAB ==="
    du -sh ~/Library/Caches/MathWorks/ 2>/dev/null
    du -sh ~/Library/Application\ Support/MathWorks/MATLAB/ 2>/dev/null
    ;;

  *)
    echo "Unknown app: $APP"
    echo "Trying fuzzy search..."
    du -sh ~/Library/Caches/* 2>/dev/null | grep -i "$APP" || echo "Not found"
    du -sh ~/Library/Application\ Support/*/Cache* 2>/dev/null | grep -i "$APP" || true
    ;;
esac
