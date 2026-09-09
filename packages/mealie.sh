#!/usr/bin/env bash
set -e
echo "Installing mealie (Recipe manager)..."
docker run -d --name mealie --restart unless-stopped \
  -p 9925:9000 \
  -v mealie-data:/app/data \
  ghcr.io/mealie-recipes/mealie:latest
echo "mealie installed."
