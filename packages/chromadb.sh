#!/usr/bin/env bash
set -e
echo "Installing chromadb (Vector database for embeddings)..."
docker run -d --name chromadb --restart unless-stopped \
  -p 8128:8000 \
  -v chromadb-data:/chroma/chroma \
  chromadb/chroma:latest
echo "chromadb installed."
