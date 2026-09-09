#!/usr/bin/env bash
set -e
echo "Installing freshrss (RSS feed reader)..."
docker run -d --name freshrss --restart unless-stopped \
  -p 8095:80 \
  -v freshrss-data:/config \
  linuxserver/freshrss:latest
echo "freshrss installed."
