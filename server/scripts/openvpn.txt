#!/usr/bin/env bash
set -e
echo "Installing openvpn (VPN server)..."
docker run -d --name openvpn --restart unless-stopped \
  -p 1194:1194 \
  -v openvpn-data:/etc/openvpn \
  kylemanna/openvpn:latest
echo "openvpn installed."
