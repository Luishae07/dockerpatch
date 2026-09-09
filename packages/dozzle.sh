#!/usr/bin/env bash
set -e
echo "Installing dozzle (Real-time Docker log viewer)..."
docker run -d --name dozzle --restart unless-stopped \
  -p 8118:8080 \
  amir20/dozzle:latest
echo "dozzle installed."
