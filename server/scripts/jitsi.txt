#!/usr/bin/env bash
set -e
echo "Installing jitsi (Self-hosted video conferencing)..."
docker run -d --name jitsi --restart unless-stopped \
  -p 8443:443 \
  jitsi/web:latest
echo "jitsi installed."
