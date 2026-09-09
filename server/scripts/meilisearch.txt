#!/usr/bin/env bash
set -e
echo "Installing meilisearch (Lightweight search engine)..."
docker run -d --name meilisearch --restart unless-stopped \
  -p 7700:7700 \
  -v meilisearch-data:/meili_data \
  getmeili/meilisearch:latest
echo "meilisearch installed."
