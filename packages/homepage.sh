#!/usr/bin/env bash
set -e
echo "Installing homepage (Customizable dashboard/homepage)..."
docker run -d --name homepage --restart unless-stopped \
  -p 3003:3000 \
  -v homepage-data:/app/config \
  ghcr.io/gethomepage/homepage:latest
echo "homepage installed."
