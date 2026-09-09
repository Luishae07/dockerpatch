#!/usr/bin/env bash
set -e
echo "Installing tailscale (Mesh VPN)..."
docker run -d --name tailscale --restart unless-stopped \
  -v tailscale-data:/var/lib/tailscale \
  tailscale/tailscale:latest
echo "tailscale installed."
