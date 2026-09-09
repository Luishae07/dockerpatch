#!/usr/bin/env bash
set -e
echo "Installing wordpress (CMS/blogging platform)..."
docker run -d --name wordpress --restart unless-stopped \
  -p 8113:80 \
  -v wordpress-data:/var/www/html \
  wordpress:latest
echo "wordpress installed."
