#!/usr/bin/env bash
set -e
echo "Installing nextcloud (Self-hosted cloud storage/office)..."
docker run -d --name nextcloud --restart unless-stopped \
  -p 8083:80 \
  -v nextcloud-data:/var/www/html \
  nextcloud:latest
echo "nextcloud installed."
