#!/usr/bin/env bash
set -e
echo "Installing hedgedoc (Collaborative markdown editor)..."
docker run -d --name hedgedoc --restart unless-stopped \
  -p 3008:3000 \
  -v hedgedoc-data:/hedgedoc/public/uploads \
  quay.io/hedgedoc/hedgedoc:latest
echo "hedgedoc installed."
