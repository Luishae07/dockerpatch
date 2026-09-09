#!/usr/bin/env bash
set -e
echo "Installing strapi (Headless CMS)..."
docker run -d --name strapi --restart unless-stopped \
  -p 1337:1337 \
  -v strapi-data:/srv/app \
  strapi/strapi:latest
echo "strapi installed."
