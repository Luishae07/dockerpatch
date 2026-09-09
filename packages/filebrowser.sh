#!/usr/bin/env bash
set -e
echo "Installing filebrowser (Web file manager)..."
docker run -d --name filebrowser --restart unless-stopped \
  -p 8081:80 \
  -v filebrowser-data:/srv \
  filebrowser/filebrowser:latest
echo "filebrowser installed."
