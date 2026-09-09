#!/usr/bin/env bash
set -e
echo "Installing headscale (Self-hosted Tailscale control server)..."
docker run -d --name headscale --restart unless-stopped \
  -p 8092:8080 \
  -v headscale-data:/etc/headscale \
  headscale/headscale:latest
echo "headscale installed."
