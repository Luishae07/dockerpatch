#!/usr/bin/env bash
set -e
echo "Installing resilio (P2P file sync)..."
docker run -d --name resilio --restart unless-stopped \
  -p 8888:8888 \
  -v resilio-data:/mnt/sync \
  resilio/sync:latest
echo "resilio installed."
