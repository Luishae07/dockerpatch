#!/usr/bin/env bash
set -e
echo "Installing wallabag (Read-it-later article saver)..."
docker run -d --name wallabag --restart unless-stopped \
  -p 8097:80 \
  -v wallabag-data:/var/www/wallabag/data \
  wallabag/wallabag:latest
echo "wallabag installed."
