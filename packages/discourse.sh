#!/usr/bin/env bash
set -e
echo "Installing discourse (Forum/discussion platform)..."
docker run -d --name discourse --restart unless-stopped \
  -p 8111:3000 \
  -v discourse-data:/bitnami \
  bitnami/discourse:latest
echo "discourse installed."
