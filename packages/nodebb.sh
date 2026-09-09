#!/usr/bin/env bash
set -e
echo "Installing nodebb (Forum platform)..."
docker run -d --name nodebb --restart unless-stopped \
  -p 4567:4567 \
  -v nodebb-data:/usr/src/app/public/uploads \
  nodebb/docker:latest
echo "nodebb installed."
