#!/usr/bin/env bash
set -e
echo "Installing lychee (Photo management system)..."
docker run -d --name lychee --restart unless-stopped \
  -p 8139:80 \
  -v lychee-data:/uploads \
  lycheeorg/lychee:latest
echo "lychee installed."
