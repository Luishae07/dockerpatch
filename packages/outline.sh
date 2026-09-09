#!/usr/bin/env bash
set -e
echo "Installing outline (Team knowledge base/wiki)..."
docker run -d --name outline --restart unless-stopped \
  -p 3005:3000 \
  -v outline-data:/var/lib/outline/data \
  outlinewiki/outline:latest
echo "outline installed."
