#!/usr/bin/env bash
set -e
echo "Installing rocketchat (Team chat platform)..."
docker run -d --name rocketchat --restart unless-stopped \
  -p 3011:3000 \
  -v rocketchat-data:/app/uploads \
  rocket.chat:latest
echo "rocketchat installed."
