#!/usr/bin/env bash
set -e
echo "Installing piwigo (Photo gallery software)..."
docker run -d --name piwigo --restart unless-stopped \
  -p 8138:80 \
  -v piwigo-data:/config \
  linuxserver/piwigo:latest
echo "piwigo installed."
