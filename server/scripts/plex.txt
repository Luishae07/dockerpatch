#!/usr/bin/env bash
set -e
echo "Installing plex (Media server)..."
docker run -d --name plex --restart unless-stopped \
  -p 32400:32400 \
  -v plex-data:/config \
  plexinc/pms-docker:latest
echo "plex installed."
