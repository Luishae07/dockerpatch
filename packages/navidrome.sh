#!/usr/bin/env bash
set -e
echo "Installing navidrome (Self-hosted music streaming)..."
docker run -d --name navidrome --restart unless-stopped \
  -p 4533:4533 \
  -v navidrome-data:/data \
  deluan/navidrome:latest
echo "navidrome installed."
