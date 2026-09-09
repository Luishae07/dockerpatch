#!/usr/bin/env bash
set -e
echo "Installing funkwhale (Federated music streaming)..."
docker run -d --name funkwhale --restart unless-stopped \
  -p 8137:80 \
  -v funkwhale-data:/data \
  funkwhale/all-in-one:latest
echo "funkwhale installed."
