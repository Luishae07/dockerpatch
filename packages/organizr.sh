#!/usr/bin/env bash
set -e
echo "Installing organizr (Unified homelab dashboard)..."
docker run -d --name organizr --restart unless-stopped \
  -p 8154:80 \
  -v organizr-data:/config \
  organizr/organizr:latest
echo "organizr installed."
