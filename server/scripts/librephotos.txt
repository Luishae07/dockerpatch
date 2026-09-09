#!/usr/bin/env bash
set -e
echo "Installing librephotos (AI-powered self-hosted photos)..."
docker run -d --name librephotos --restart unless-stopped \
  -p 3018:3000 \
  -v librephotos-data:/data \
  reallibrephotos/librephotos:latest
echo "librephotos installed."
