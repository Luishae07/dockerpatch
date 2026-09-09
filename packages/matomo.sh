#!/usr/bin/env bash
set -e
echo "Installing matomo (Web analytics platform)..."
docker run -d --name matomo --restart unless-stopped \
  -p 8116:80 \
  -v matomo-data:/var/www/html \
  matomo:latest
echo "matomo installed."
