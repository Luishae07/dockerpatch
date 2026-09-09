#!/usr/bin/env bash
set -e
echo "Installing watchtower (Auto-updates running containers)..."
docker run -d --name watchtower --restart unless-stopped \
  containrrr/watchtower
echo "watchtower installed."
