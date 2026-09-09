#!/usr/bin/env bash
set -e
echo "Installing flarum (Lightweight forum software)..."
docker run -d --name flarum --restart unless-stopped \
  -p 8112:80 \
  -v flarum-data:/config \
  linuxserver/flarum:latest
echo "flarum installed."
