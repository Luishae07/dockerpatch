#!/usr/bin/env bash
set -e
echo "Installing focalboard (Project management/notes)..."
docker run -d --name focalboard --restart unless-stopped \
  -p 8105:8000 \
  -v focalboard-data:/data \
  mattermost/focalboard:latest
echo "focalboard installed."
