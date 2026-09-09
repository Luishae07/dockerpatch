#!/usr/bin/env bash
set -e
echo "Installing windmill (Developer platform for scripts/workflows)..."
docker run -d --name windmill --restart unless-stopped \
  -p 8151:8000 \
  ghcr.io/windmill-labs/windmill:main
echo "windmill installed."
