#!/usr/bin/env bash
set -e
echo "Installing statping (Status page generator)..."
docker run -d --name statping --restart unless-stopped \
  -p 8121:8080 \
  -v statping-data:/app \
  adamboutcher/statping-ng:latest
echo "statping installed."
