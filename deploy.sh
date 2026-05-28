#!/usr/bin/env bash
# RunCloud Git Deployment script for WebRock Digital Presentation.
# Static HTML project — no build step.
# Runs from webroot AFTER RunCloud performs `git pull`.

set -euo pipefail

# Force-sync to remote main (drops any stray local changes on the server).
git fetch --all --prune
git reset --hard origin/main
git clean -fd

# Nginx-friendly permissions: files 644, dirs 755.
find . -type f -not -path "./.git/*" -exec chmod 644 {} \;
find . -type d -not -path "./.git/*" -exec chmod 755 {} \;

# Bump mtime so Last-Modified / ETag reflect the new release.
touch "index.html" "presentation.html" "WebRock Digital - Presentation.html"

echo "Deploy OK: $(date -u +%FT%TZ) — commit $(git rev-parse --short HEAD)"
