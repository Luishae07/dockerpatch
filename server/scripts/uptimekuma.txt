#!/usr/bin/env bash
set -e
echo "Installing uptimekuma (Status/uptime monitoring dashboard)..."
docker run -d --name uptimekuma --restart unless-stopped \
  -p 3001:3001 \
  -v uptimekuma-data:/app/data \
  louislam/uptime-kuma:1
echo "uptimekuma installed."
