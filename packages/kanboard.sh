#!/usr/bin/env bash
set -e
echo "Installing kanboard (Kanban project management)..."
docker run -d --name kanboard --restart unless-stopped \
  -p 8103:80 \
  -v kanboard-data:/var/www/app/data \
  kanboard/kanboard:latest
echo "kanboard installed."
