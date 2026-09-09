#!/usr/bin/env bash
set -e
echo "Installing photoprism (AI-powered photo library)..."
docker run -d --name photoprism --restart unless-stopped \
  -p 2342:2342 \
  -v photoprism-data:/photoprism/storage \
  photoprism/photoprism:latest
echo "photoprism installed."
