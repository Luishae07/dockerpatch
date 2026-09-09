#!/usr/bin/env bash
set -e
echo "Installing payload (Headless CMS (TypeScript))..."
docker run -d --name payload --restart unless-stopped \
  -p 3012:3000 \
  payloadcms/payload:latest
echo "payload installed."
