#!/usr/bin/env bash
set -e
echo "Installing typesense (Fast search engine)..."
docker run -d --name typesense --restart unless-stopped \
  -p 8126:8108 \
  -v typesense-data:/data \
  typesense/typesense:latest
echo "typesense installed."
