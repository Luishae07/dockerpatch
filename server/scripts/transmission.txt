#!/usr/bin/env bash
set -e
echo "Installing transmission (BitTorrent client)..."
docker run -d --name transmission --restart unless-stopped \
  -p 9091:9091 \
  -v transmission-data:/config \
  linuxserver/transmission:latest
echo "transmission installed."
