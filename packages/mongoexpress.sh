#!/usr/bin/env bash
set -e
echo "Installing mongoexpress (MongoDB admin UI)..."
docker run -d --name mongoexpress --restart unless-stopped \
  -p 8164:8081 \
  mongo-express:latest
echo "mongoexpress installed."
