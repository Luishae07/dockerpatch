#!/usr/bin/env bash
set -e
echo "Installing bookstack (Wiki/documentation platform)..."
docker run -d --name bookstack --restart unless-stopped \
  -p 6875:80 \
  -v bookstack-data:/config \
  linuxserver/bookstack:latest
echo "bookstack installed."
