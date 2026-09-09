#!/usr/bin/env bash
set -e
echo "Installing cachet (Status page system)..."
docker run -d --name cachet --restart unless-stopped \
  -p 8122:8000 \
  -v cachet-data:/var/www/html \
  cachethq/docker:latest
echo "cachet installed."
