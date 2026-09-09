#!/usr/bin/env bash
set -e
echo "Installing airsonic (Music streaming server)..."
docker run -d --name airsonic --restart unless-stopped \
  -p 4040:4040 \
  -v airsonic-data:/config \
  linuxserver/airsonic-advanced:latest
echo "airsonic installed."
