#!/usr/bin/env bash
set -e
echo "Installing miniflux (Minimalist RSS reader)..."
docker run -d --name miniflux --restart unless-stopped \
  -p 8096:8080 \
  miniflux/miniflux:latest
echo "miniflux installed."
