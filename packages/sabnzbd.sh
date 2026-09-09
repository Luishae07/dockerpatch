#!/usr/bin/env bash
set -e
echo "Installing sabnzbd (Usenet download client)..."
docker run -d --name sabnzbd --restart unless-stopped \
  -p 8090:8080 \
  -v sabnzbd-data:/config \
  linuxserver/sabnzbd:latest
echo "sabnzbd installed."
