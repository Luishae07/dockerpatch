#!/usr/bin/env bash
set -e
echo "Installing Open WebUI..."
docker run -d -p 3000:8080 \
  -v open-webui:/app/backend/data \
  --name open-webui \
  --restart unless-stopped \
  ghcr.io/open-webui/open-webui:main
echo "Open WebUI running at http://localhost:3000"
