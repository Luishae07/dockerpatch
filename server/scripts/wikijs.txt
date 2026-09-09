#!/usr/bin/env bash
set -e
echo "Installing wikijs (Wiki platform)..."
docker run -d --name wikijs --restart unless-stopped \
  -p 3006:3000 \
  -v wikijs-data:/config \
  linuxserver/wikijs:latest
echo "wikijs installed."
