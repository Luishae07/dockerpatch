#!/usr/bin/env bash
set -e
echo "Installing directus (Headless CMS/data platform)..."
docker run -d --name directus --restart unless-stopped \
  -p 8114:8055 \
  -v directus-data:/directus/uploads \
  directus/directus:latest
echo "directus installed."
