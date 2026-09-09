#!/usr/bin/env bash
set -e
echo "Installing shlink (URL shortener with API)..."
docker run -d --name shlink --restart unless-stopped \
  -p 8131:8080 \
  -v shlink-data:/data \
  shlinkio/shlink:latest
echo "shlink installed."
