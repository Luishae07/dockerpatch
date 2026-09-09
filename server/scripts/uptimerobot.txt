#!/usr/bin/env bash
set -e
echo "Installing uptimerobot (Uptime monitoring (duplicate image, alt name))..."
docker run -d --name uptimerobot --restart unless-stopped \
  -p 3014:3001 \
  -v uptimerobot-data:/app/data \
  louislam/uptime-kuma:1
echo "uptimerobot installed."
