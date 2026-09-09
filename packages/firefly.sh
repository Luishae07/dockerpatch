#!/usr/bin/env bash
set -e
echo "Installing firefly (Personal finance manager)..."
docker run -d --name firefly --restart unless-stopped \
  -p 8100:8080 \
  -v firefly-data:/var/www/html/storage/upload \
  fireflyiii/core:latest
echo "firefly installed."
