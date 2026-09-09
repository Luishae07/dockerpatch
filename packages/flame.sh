#!/usr/bin/env bash
set -e
echo "Installing flame (Start page/dashboard for self-hosted services)..."
docker run -d --name flame --restart unless-stopped \
  -p 5005:5005 \
  -v flame-data:/app/data \
  pawelmalak/flame:latest
echo "flame installed."
