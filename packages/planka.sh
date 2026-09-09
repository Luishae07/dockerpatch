#!/usr/bin/env bash
set -e
echo "Installing planka (Kanban board (Trello alternative))..."
docker run -d --name planka --restart unless-stopped \
  -p 3009:1337 \
  -v planka-data:/app/public/user-avatars \
  ghcr.io/plankanban/planka:latest
echo "planka installed."
