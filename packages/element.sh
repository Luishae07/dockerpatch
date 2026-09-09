#!/usr/bin/env bash
set -e
echo "Installing element (Matrix chat client web UI)..."
docker run -d --name element --restart unless-stopped \
  -p 8109:80 \
  vectorim/element-web:latest
echo "element installed."
