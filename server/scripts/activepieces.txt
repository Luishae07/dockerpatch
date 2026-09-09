#!/usr/bin/env bash
set -e
echo "Installing activepieces (No-code automation (Zapier alternative))..."
docker run -d --name activepieces --restart unless-stopped \
  -p 8152:80 \
  -v activepieces-data:/root/.activepieces \
  activepieces/activepieces:latest
echo "activepieces installed."
