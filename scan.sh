#!/bin/bash
# disk-sweeper/scan.sh — Scan all user-level caches

set -e

echo "=== User Caches (~/Library/Caches/) ==="
du -sh ~/Library/Caches/* 2>/dev/null | sort -rh | head -20

echo ""
echo "=== Logs (~/Library/Logs/) ==="
du -sh ~/Library/Logs/* 2>/dev/null | sort -rh | head -10

echo ""
echo "=== App Caches (~/Library/Application Support/) ==="
du -sh ~/Library/Application\ Support/*/Cache* 2>/dev/null | sort -rh | head -10
du -sh ~/Library/Application\ Support/*/cache* 2>/dev/null | sort -rh | head -10

echo ""
echo "=== Temp Directories ==="
du -sh /tmp/* 2>/dev/null | sort -rh | head -10

echo ""
echo "=== Homebrew Cache ==="
if command -v brew &>/dev/null; then
    echo "Homebrew cache: $(du -sh $(brew --cache) 2>/dev/null | cut -f1)"
fi

echo ""
echo "=== Largest Folders in Home ==="
du -sh ~/* 2>/dev/null | sort -rh | head -15

echo ""
echo "=== Disk Overview ==="
df -h /
