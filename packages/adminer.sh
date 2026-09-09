#!/usr/bin/env bash
set -e
echo "Installing adminer (Database management UI)..."
docker run -d --name adminer --restart unless-stopped \
  -p 8082:8080 \
  adminer:latest
echo "adminer installed."
