#!/usr/bin/env bash
set -e
echo "Installing searxng (Privacy-respecting metasearch engine)..."
docker run -d --name searxng --restart unless-stopped \
  -p 8130:8080 \
  -v searxng-data:/etc/searxng \
  searxng/searxng:latest
echo "searxng installed."
