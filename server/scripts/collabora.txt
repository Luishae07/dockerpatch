#!/usr/bin/env bash
set -e
echo "Installing collabora (LibreOffice-based online editor)..."
docker run -d --name collabora --restart unless-stopped \
  -p 9980:9980 \
  collabora/code:latest
echo "collabora installed."
