#!/usr/bin/env bash
set -e
echo "Installing radarr (Movie collection manager)..."
docker run -d --name radarr --restart unless-stopped \
  -p 7878:7878 \
  -v radarr-data:/config \
  linuxserver/radarr:latest
echo "radarr installed."
