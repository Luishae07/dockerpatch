#!/usr/bin/env bash
set -e
echo "Installing wireguard (VPN server)..."
docker run -d --name wireguard --restart unless-stopped \
  -p 51820:51820 \
  -v wireguard-data:/config \
  linuxserver/wireguard:latest
echo "wireguard installed."
