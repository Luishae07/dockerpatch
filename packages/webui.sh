#!/usr/bin/env bash
set -e
echo "Installing webui (ChatGPT-like UI for local LLMs)..."
docker run -d --name webui --restart unless-stopped \
  -p 3000:8080 \
  -v webui-data:/app/backend/data \
  ghcr.io/open-webui/open-webui:main
echo "webui installed."
