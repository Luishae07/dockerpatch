#!/usr/bin/env bash
set -e
echo "Installing qdrant (Vector database)..."
docker run -d --name qdrant --restart unless-stopped \
  -p 6333:6333 \
  -v qdrant-data:/qdrant/storage \
  qdrant/qdrant:latest
echo "qdrant installed."
