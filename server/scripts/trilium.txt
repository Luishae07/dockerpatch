#!/usr/bin/env bash
set -e
echo "Installing trilium (Personal knowledge base)..."
docker run -d --name trilium --restart unless-stopped \
  -p 8099:8080 \
  -v trilium-data:/home/node/trilium-data \
  zadam/trilium:latest
echo "trilium installed."
