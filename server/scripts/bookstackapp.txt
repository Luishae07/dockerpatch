#!/usr/bin/env bash
set -e
echo "Installing bookstackapp (Documentation wiki (alt image))..."
docker run -d --name bookstackapp --restart unless-stopped \
  -p 8102:80 \
  -v bookstackapp-data:/config \
  solidnerd/bookstack:latest
echo "bookstackapp installed."
