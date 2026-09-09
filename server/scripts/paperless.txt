#!/usr/bin/env bash
set -e
echo "Installing paperless (Document management/OCR)..."
docker run -d --name paperless --restart unless-stopped \
  -p 8101:8000 \
  -v paperless-data:/usr/src/paperless/media \
  ghcr.io/paperless-ngx/paperless-ngx:latest
echo "paperless installed."
