#!/usr/bin/env bash
set -e
echo "Installing qbittorrent (BitTorrent client)..."
docker run -d --name qbittorrent --restart unless-stopped \
  -p 8089:8080 \
  -v qbittorrent-data:/config \
  linuxserver/qbittorrent:latest
echo "qbittorrent installed."
