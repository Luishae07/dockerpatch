#!/usr/bin/env bash
set -e
echo "Installing homarr (Customizable server dashboard)..."
docker run -d --name homarr --restart unless-stopped \
  -p 7575:7575 \
  -v homarr-data:/app/data/configs \
  ghcr.io/ajnart/homarr:latest
echo "homarr installed."
