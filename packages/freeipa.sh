#!/usr/bin/env bash
set -e
echo "Installing freeipa (Identity management server)..."
docker run -d --name freeipa --restart unless-stopped \
  -p 8161:80 \
  -v freeipa-data:/data \
  freeipa/freeipa-server:latest
echo "freeipa installed."
