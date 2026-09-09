#!/usr/bin/env bash
set -e
echo "Installing redis (In-memory key-value store)..."
docker run -d --name redis --restart unless-stopped \
  -p 6379:6379 \
  -v redis-data:/data \
  redis:latest
echo "redis installed."
