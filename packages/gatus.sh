#!/usr/bin/env bash
set -e
echo "Installing gatus (Health check/status page)..."
docker run -d --name gatus --restart unless-stopped \
  -p 8123:8080 \
  twinproduction/gatus:latest
echo "gatus installed."
