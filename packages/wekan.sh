#!/usr/bin/env bash
set -e
echo "Installing wekan (Trello-like kanban board)..."
docker run -d --name wekan --restart unless-stopped \
  -p 8104:8080 \
  wekanteam/wekan:latest
echo "wekan installed."
