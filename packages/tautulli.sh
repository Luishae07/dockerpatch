#!/usr/bin/env bash
set -e
echo "Installing tautulli (Plex monitoring/stats)..."
docker run -d --name tautulli --restart unless-stopped \
  -p 8181:8181 \
  -v tautulli-data:/config \
  linuxserver/tautulli:latest
echo "tautulli installed."
