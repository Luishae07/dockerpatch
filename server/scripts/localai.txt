#!/usr/bin/env bash
set -e
echo "Installing localai (Local OpenAI-compatible API)..."
docker run -d --name localai --restart unless-stopped \
  -p 8129:8080 \
  -v localai-data:/models \
  localai/localai:latest
echo "localai installed."
