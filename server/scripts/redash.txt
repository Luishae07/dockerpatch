#!/usr/bin/env bash
set -e
echo "Installing redash (Data query/visualization tool)..."
docker run -d --name redash --restart unless-stopped \
  -p 5008:5000 \
  redash/redash:latest
echo "redash installed."
