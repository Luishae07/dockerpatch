#!/usr/bin/env bash
set -e
echo "Installing calibreweb (Ebook library web UI)..."
docker run -d --name calibreweb --restart unless-stopped \
  -p 8135:8083 \
  -v calibreweb-data:/config \
  linuxserver/calibre-web:latest
echo "calibreweb installed."
