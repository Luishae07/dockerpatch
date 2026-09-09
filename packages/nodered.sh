#!/usr/bin/env bash
set -e
echo "Installing nodered (Flow-based automation tool)..."
docker run -d --name nodered --restart unless-stopped \
  -p 1880:1880 \
  -v nodered-data:/data \
  nodered/node-red:latest
echo "nodered installed."
