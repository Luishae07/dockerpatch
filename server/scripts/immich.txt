#!/usr/bin/env bash
set -e
echo "Installing immich (Self-hosted photo/video backup)..."
docker run -d --name immich --restart unless-stopped \
  -p 2283:2283 \
  -v immich-data:/usr/src/app/upload \
  ghcr.io/immich-app/immich-server:release
echo "immich installed."
