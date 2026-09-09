#!/usr/bin/env bash
set -e
echo "Installing mongodb (Document database)..."
docker run -d --name mongodb --restart unless-stopped \
  -p 27017:27017 \
  -v mongodb-data:/data/db \
  mongo:latest
echo "mongodb installed."
