#!/usr/bin/env bash
set -e
echo "Installing speedtest (Internet speed test tracking)..."
docker run -d --name speedtest --restart unless-stopped \
  -p 8119:80 \
  -v speedtest-data:/config \
  linuxserver/speedtest-tracker:latest
echo "speedtest installed."
