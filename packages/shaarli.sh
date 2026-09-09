#!/usr/bin/env bash
set -e
echo "Installing shaarli (Bookmark/link sharing)..."
docker run -d --name shaarli --restart unless-stopped \
  -p 8140:80 \
  -v shaarli-data:/config \
  linuxserver/shaarli:latest
echo "shaarli installed."
