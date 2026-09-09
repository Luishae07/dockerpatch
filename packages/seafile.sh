#!/usr/bin/env bash
set -e
echo "Installing seafile (File sync and share)..."
docker run -d --name seafile --restart unless-stopped \
  -p 8087:80 \
  -v seafile-data:/shared \
  seafileltd/seafile-mc:latest
echo "seafile installed."
