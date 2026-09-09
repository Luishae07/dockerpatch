#!/usr/bin/env bash
set -e
echo "Installing portainer (Docker management UI)..."
docker run -d --name portainer --restart unless-stopped \
  -p 9443:9443 \
  -p 8000:8000 \
  -v portainer-data:/data \
  portainer/portainer-ce:latest
echo "portainer installed."
