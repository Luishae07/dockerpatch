#!/usr/bin/env bash
set -e
echo "Installing dbeaver (Universal database tool (web))..."
docker run -d --name dbeaver --restart unless-stopped \
  -p 8165:8080 \
  webcyphersolutions/dbeaver-web:latest
echo "dbeaver installed."
