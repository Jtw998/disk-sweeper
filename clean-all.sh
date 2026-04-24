#!/bin/bash
# disk-sweeper/clean-all.sh — Clean ALL user caches (dangerous)

echo "=========================================="
echo "  [!] WARNING: Cleaning ALL user caches!"
echo "=========================================="
echo ""
echo "The following will be deleted:"
echo ""
echo "  1. ~/Library/Caches/*         — user caches"
echo "  2. ~/.npm/_cacache            — npm cache"
echo "  3. ~/Library/Caches/pip/*     — pip cache"
echo "  4. ~/Library/Caches/Homebrew — Homebrew download cache"
echo ""
echo "Skipped: /tmp/* (symlink to /private/tmp on macOS — too dangerous)"
echo "Skipped: rm -rf ~/Library/Logs/* (may break diagnostic tools)"
echo ""
read -p "Type YES to confirm: " confirm

if [[ "$confirm" != "YES" ]]; then
    echo "Cancelled."
    exit 0
fi

echo ""
echo ">>> Cleaning..."

before=$(df -h / | tail -1 | awk '{print $4}')

rm -rf ~/Library/Caches/* 2>/dev/null && echo "[OK] User caches cleaned"
rm -rf ~/.npm/_cacache 2>/dev/null && echo "[OK] npm cache cleaned"
rm -rf ~/Library/Caches/pip/* 2>/dev/null && echo "[OK] pip cache cleaned"
rm -rf ~/Library/Caches/Homebrew/* 2>/dev/null && echo "[OK] Homebrew download cache cleaned"

if command -v conda &>/dev/null; then
    conda clean --all -y 2>/dev/null && echo "[OK] conda cleaned"
fi

if command -v brew &>/dev/null; then
    brew cleanup -s 2>/dev/null && echo "[OK] Homebrew cleaned"
fi

after=$(df -h / | tail -1 | awk '{print $4}')
echo ""
echo "=========================================="
echo "Done."
echo "Free before: $before"
echo "Free after:  $after"
echo "=========================================="
