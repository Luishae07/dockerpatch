#!/usr/bin/env bash
set -e
echo "Installing drone (CI/CD server)..."
docker run -d --name drone --restart unless-stopped \
  -p 8085:80 \
  -v drone-data:/data \
  drone/drone:latest
echo "drone installed."
