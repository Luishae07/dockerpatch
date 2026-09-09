#!/usr/bin/env bash
set -e
echo "Installing bazarr (Subtitle manager)..."
docker run -d --name bazarr --restart unless-stopped \
  -p 6767:6767 \
  -v bazarr-data:/config \
  linuxserver/bazarr:latest
echo "bazarr installed."
