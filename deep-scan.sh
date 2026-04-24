#!/bin/bash
# disk-sweeper/deep-scan.sh — Deep scan: find large files and deep caches
set -euo pipefail

echo "=========================================="
echo "      Disk Sweeper — Deep Scan"
echo "=========================================="

echo ""
echo "=== Disk Overview ==="
df -h /

echo ""
echo "=== Folders >500MB in Home ==="
du -sh ~/* 2>/dev/null | awk '$1 ~ /G/{print}'

echo ""
echo "=== Files >100MB in Home ==="
find ~ -type f -size +100M 2>/dev/null | head -20 | xargs -I{} du -h {} 2>/dev/null

echo ""
echo "=== Hidden Directories >100MB ==="
du -sh ~/.* 2>/dev/null | sort -rh | awk '$1 ~ /G|M/{print}' | head -20

echo ""
echo "=== Xcode Big Dirs ==="
du -sh ~/Library/Developer/Xcode/DerivedData/ 2>/dev/null
du -sh ~/Library/Developer/Xcode/Archives/ 2>/dev/null
du -sh ~/Library/Developer/CoreSimulator/Caches/ 2>/dev/null

echo ""
echo "=== Homebrew ==="
du -sh /usr/local/Cellar/ 2>/dev/null
du -sh ~/.cache/pip 2>/dev/null
du -sh ~/Library/Caches/pip 2>/dev/null

echo ""
echo "=== Docker Desktop ==="
if [[ -d ~/Library/Containers/com.docker.docker/ ]]; then
    du -sh ~/Library/Containers/com.docker.docker/
fi

echo ""
echo "=== Large node_modules ==="
find ~ -name "node_modules" -type d 2>/dev/null | head -10 | xargs -I{} du -sh {} 2>/dev/null

echo ""
echo "=== Python __pycache__ ==="
total_pycache=$(find ~ -name "__pycache__" -type d 2>/dev/null | xargs du -sh 2>/dev/null | awk '{sum+=$1} END {print sum " (total)"}')
echo "Total ~pycache__: ${total_pycache:-0 (total)}"

echo ""
echo "=== .Trash ==="
du -sh ~/.Trash 2>/dev/null
