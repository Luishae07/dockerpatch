#!/usr/bin/env bash
set -e
echo "Installing lidarr (Music collection manager)..."
docker run -d --name lidarr --restart unless-stopped \
  -p 8686:8686 \
  -v lidarr-data:/config \
  linuxserver/lidarr:latest
echo "lidarr installed."
