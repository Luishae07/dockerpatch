#!/usr/bin/env bash
set -e
echo "Installing librenms (Network monitoring system)..."
docker run -d --name librenms --restart unless-stopped \
  -p 8155:8000 \
  -v librenms-data:/data \
  librenms/librenms:latest
echo "librenms installed."
