#!/usr/bin/env bash
set -e
echo "Installing linkding (Bookmark manager)..."
docker run -d --name linkding --restart unless-stopped \
  -p 9091:9090 \
  -v linkding-data:/etc/linkding/data \
  sissbruecker/linkding:latest
echo "linkding installed."
