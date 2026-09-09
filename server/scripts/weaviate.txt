#!/usr/bin/env bash
set -e
echo "Installing weaviate (Vector database for AI apps)..."
docker run -d --name weaviate --restart unless-stopped \
  -p 8127:8080 \
  -v weaviate-data:/var/lib/weaviate \
  semitechnologies/weaviate:latest
echo "weaviate installed."
