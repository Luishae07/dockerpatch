#!/usr/bin/env bash
set -e
echo "Installing redmine (Project management/issue tracking)..."
docker run -d --name redmine --restart unless-stopped \
  -p 3010:3000 \
  -v redmine-data:/usr/src/redmine/files \
  redmine:latest
echo "redmine installed."
