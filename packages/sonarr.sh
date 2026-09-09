#!/usr/bin/env bash
set -e
echo "Installing sonarr (TV collection manager)..."
docker run -d --name sonarr --restart unless-stopped \
  -p 8989:8989 \
  -v sonarr-data:/config \
  linuxserver/sonarr:latest
echo "sonarr installed."
