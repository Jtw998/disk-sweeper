#!/bin/bash
# disk-sweeper/clean-app.sh — Clean cache for specific app(s)
set -euo pipefail

FORCE=false
CHECK=false
APPS=()

for arg in "$@"; do
    case "$arg" in
        --force) FORCE=true ;;
        --check) CHECK=true ;;
        -h|--help)
            echo "Usage: $0 [options] <app> [app2 ...]"
            echo "Options:"
            echo "  --check    show what would be deleted (dry run)"
            echo "  --force    skip confirmation prompt"
            exit 0
            ;;
        -*) echo "Unknown option: $arg" >&2; exit 1 ;;
        *)  APPS+=("$arg") ;;
    esac
done

if [[ ${#APPS[@]} -eq 0 ]]; then
    echo "Usage: $0 [options] <app> [app2 ...]"
    echo "Example: $0 chrome vscode"
    exit 1
fi

if [[ "$CHECK" == true ]]; then
    echo "[DRY RUN] Nothing will be deleted."
    echo ""
fi

if [[ "$FORCE" != true && "$CHECK" != true ]]; then
    echo "Cleaning: ${APPS[*]}"
    read -p "Type YES to confirm: " confirm
    if [[ "$confirm" != "YES" ]]; then
        echo "Cancelled."
        exit 0
    fi
fi

cleanup() {
    local label="$1"
    local path="$2"
    if [[ -d "$path" ]]; then
        size=$(du -sh "$path" 2>/dev/null | cut -f1)
        if [[ "$CHECK" == true ]]; then
            echo "[WOULD DELETE] $label ($size at $path)"
        else
            rm -rf "$path"/*
            echo "[OK] $label cleaned ($size freed)"
        fi
    else
        echo "[--] $label not found or already empty"
    fi
}

for APP in "${APPS[@]}"; do
    echo ">>> Cleaning: $APP"

    case "$APP" in
      chrome)
        echo "[!] Close Chrome first"
        cleanup "Chrome cache" ~/Library/Caches/Google/Chrome/
        cleanup "Chrome WebCache" ~/Library/Application\ Support/Google/Chrome/Default/Cache*
        cleanup "Chrome Code Cache" ~/Library/Application\ Support/Google/Chrome/Default/Code\ Cache
        ;;

      firefox)
        echo "[!] Close Firefox first"
        cleanup "Firefox cache" ~/Library/Caches/Firefox/
        cleanup "Firefox profile cache" ~/Library/Application\ Support/Firefox/Profiles/*/cache2/
        ;;

      safari)
        echo "[!] Close Safari first"
        cleanup "Safari cache" ~/Library/Caches/com.apple.Safari/
        cleanup "Safari WebKit cache" ~/Library/Caches/com.apple.Safari.WebKitCache/
        cleanup "Safari Container cache" ~/Library/Containers/com.apple.Safari/Data/Library/Caches/
        ;;

      vscode)
        echo "[!] Close VS Code first"
        cleanup "VS Code Cache" ~/Library/Application\ Support/Code/Cache/
        cleanup "VS Code CachedExtensionVSIXs" ~/Library/Application\ Support/Code/CachedExtensionVSIXs/
        cleanup "VS Code CachedData" ~/Library/Application\ Support/Code/CachedData/
        cleanup "VS Code CachedExtensions" ~/Library/Application\ Support/Code/CachedExtensions/
        cleanup "VS Code Crashpad" ~/Library/Application\ Support/Code/Crashpad/compressed/
        ;;

      cursor)
        echo "[!] Close Cursor first"
        cleanup "Cursor Cache" ~/Library/Application\ Support/Cursor/Cache/
        cleanup "Cursor CachedExtensionVSIXs" ~/Library/Application\ Support/Cursor/CachedExtensionVSIXs/
        cleanup "Cursor CachedData" ~/Library/Application\ Support/Cursor/CachedData/
        ;;

      xcode)
        echo "[!] Close Xcode first"
        cleanup "Xcode DerivedData" ~/Library/Developer/Xcode/DerivedData/
        cleanup "Xcode Archives" ~/Library/Developer/Xcode/Archives/
        cleanup "Xcode Caches" ~/Library/Caches/com.apple.dt.Xcode/
        cleanup "CoreSimulator Caches" ~/Library/Developer/CoreSimulator/Caches/
        ;;

      homebrew)
        echo "[!] Cleaning Homebrew cache..."
        BREW_CACHE=$(brew --cache 2>/dev/null)
        cleanup "Homebrew cache" "$BREW_CACHE"
        brew cleanup -s 2>/dev/null || true
        ;;

      pip)
        cleanup "pip cache" ~/Library/Caches/pip/
        ;;

      npm)
        cleanup "npm cache" ~/Library/Caches/npm/
        cleanup "npm cache (~/.npm)" ~/.npm/_cacache
        npm cache clean --force 2>/dev/null || true
        ;;

      conda)
        conda clean --all -y 2>/dev/null || true
        cleanup "conda pkgs" ~/.conda/pkgs/
        ;;

      docker)
        echo "[!] Removing unused Docker resources..."
        docker system prune -af 2>/dev/null || echo "Docker not running or not installed"
        docker volume prune -f 2>/dev/null || true
        ;;

      jetbrains|intellij|pycharm|goland|webstorm|clion)
        echo "[!] Close JetBrains IDE first"
        cleanup "JetBrains cache" ~/Library/Caches/JetBrains/
        cleanup "JetBrains IDE caches" ~/Library/Application\ Support/JetBrains/*/caches/
        ;;

      anaconda)
        cleanup "Anaconda pkgs" ~/Library/Application\ Support/Anaconda3/pkgs/
        cleanup "conda pkgs" ~/.conda/pkgs/
        ;;

      github-desktop)
        echo "[!] Close GitHub Desktop first"
        cleanup "GitHub Desktop cache" ~/Library/Caches/githubforMacOsX/
        cleanup "GitHub Desktop Cache" ~/Library/Application\ Support/GitHub\ Desktop/Cache/
        ;;

      slack)
        echo "[!] Close Slack first"
        cleanup "Slack cache" ~/Library/Caches/com.tinyspeck.slackmacgap/
        cleanup "Slack Container Cache" ~/Library/Containers/com.tinyspeck.slackmacgap/Data/Library/Application\ Support/Slack/Cache
        cleanup "Slack Container CachedData" ~/Library/Containers/com.tinyspeck.slackmacgap/Data/Library/Application\ Support/Slack/CachedData
        ;;

      discord)
        echo "[!] Close Discord first"
        cleanup "Discord cache" ~/Library/Caches/com.hnc.Discord/
        ;;

      spotify)
        echo "[!] Close Spotify first"
        cleanup "Spotify cache" ~/Library/Caches/com.spotify.client/
        ;;

      zoom)
        echo "[!] Close Zoom first"
        cleanup "Zoom cache" ~/Library/Caches/zoomus/
        ;;

      wechat)
        echo "[!] Close WeChat first"
        cleanup "WeChat cache" ~/Library/Containers/com.tencent.xinWeChat/Data/Library/Caches
        ;;

      unity)
        echo "[!] Close Unity first"
        cleanup "Unity cache" ~/Library/Caches/Unity/
        cleanup "Unity AssetServerCache" ~/Library/Application\ Support/Unity/AssetServerCacheV4
        ;;

      blender)
        echo "[!] Close Blender first"
        cleanup "Blender cache" ~/Library/Application\ Support/Blender/*/cache
        cleanup "Blender config cache" ~/Library/Application\ Support/Blender/*/config/cache
        ;;

      adobe)
        echo "[!] Close all Adobe apps first"
        cleanup "Adobe cache" ~/Library/Caches/Adobe/
        cleanup "Adobe Media Cache" ~/Library/Application\ Support/Adobe/Common/Media\ Cache*
        ;;

      matlab)
        echo "[!] Close MATLAB first"
        cleanup "MATLAB cache" ~/Library/Caches/MathWorks/
        ;;

      *)
        echo "[!!] Unknown app: $APP, skipping"
        ;;
    esac
    echo ""
done

echo "Done."
