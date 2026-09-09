#!/usr/bin/env bash
set -e
echo "Installing heimdall (Application dashboard)..."
docker run -d --name heimdall --restart unless-stopped \
  -p 8153:80 \
  -v heimdall-data:/config \
  linuxserver/heimdall:latest
echo "heimdall installed."
