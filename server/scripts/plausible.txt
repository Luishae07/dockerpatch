#!/usr/bin/env bash
set -e
echo "Installing plausible (Privacy-focused website analytics)..."
docker run -d --name plausible --restart unless-stopped \
  -p 8115:8000 \
  plausible/analytics:latest
echo "plausible installed."
