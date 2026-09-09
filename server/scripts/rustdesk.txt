#!/usr/bin/env bash
set -e
echo "Installing rustdesk (Self-hosted remote desktop server)..."
docker run -d --name rustdesk --restart unless-stopped \
  -p 21115:21115 \
  -p 21116:21116 \
  -v rustdesk-data:/root \
  rustdesk/rustdesk-server:latest
echo "rustdesk installed."
