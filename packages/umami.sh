#!/usr/bin/env bash
set -e
echo "Installing umami (Privacy-focused website analytics)..."
docker run -d --name umami --restart unless-stopped \
  -p 3013:3000 \
  ghcr.io/umami-software/umami:postgresql-latest
echo "umami installed."
