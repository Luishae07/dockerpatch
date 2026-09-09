#!/usr/bin/env bash
set -e
echo "Installing dokuwiki (Flat-file wiki)..."
docker run -d --name dokuwiki --restart unless-stopped \
  -p 8098:80 \
  -v dokuwiki-data:/config \
  linuxserver/dokuwiki:latest
echo "dokuwiki installed."
