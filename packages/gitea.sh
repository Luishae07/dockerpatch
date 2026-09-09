#!/usr/bin/env bash
set -e
echo "Installing gitea (Self-hosted Git service)..."
docker run -d --name gitea --restart unless-stopped \
  -p 3004:3000 \
  -p 2222:22 \
  -v gitea-data:/data \
  gitea/gitea:latest
echo "gitea installed."
