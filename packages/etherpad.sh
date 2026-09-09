#!/usr/bin/env bash
set -e
echo "Installing etherpad (Real-time collaborative text editor)..."
docker run -d --name etherpad --restart unless-stopped \
  -p 9001:9001 \
  -v etherpad-data:/opt/etherpad-lite/var \
  etherpad/etherpad:latest
echo "etherpad installed."
