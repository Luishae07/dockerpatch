#!/usr/bin/env bash
set -e
echo "Installing koel (Personal music streaming server)..."
docker run -d --name koel --restart unless-stopped \
  -p 8136:80 \
  phanan/koel:latest
echo "koel installed."
