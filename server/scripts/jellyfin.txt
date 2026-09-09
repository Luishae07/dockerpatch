#!/usr/bin/env bash
set -e
echo "Installing jellyfin (Media server)..."
docker run -d --name jellyfin --restart unless-stopped \
  -p 8096:8096 \
  -v jellyfin-data:/config \
  jellyfin/jellyfin:latest
echo "jellyfin installed."
