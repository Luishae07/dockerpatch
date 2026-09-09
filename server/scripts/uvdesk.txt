#!/usr/bin/env bash
set -e
echo "Installing uvdesk (Open-source helpdesk)..."
docker run -d --name uvdesk --restart unless-stopped \
  -p 8147:80 \
  uvdesk/community-app:latest
echo "uvdesk installed."
