#!/usr/bin/env bash
set -e
echo "Installing openproject (Project management platform)..."
docker run -d --name openproject --restart unless-stopped \
  -p 8107:80 \
  -v openproject-data:/var/openproject/assets \
  openproject/openproject:latest
echo "openproject installed."
