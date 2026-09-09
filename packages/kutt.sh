#!/usr/bin/env bash
set -e
echo "Installing kutt (URL shortener)..."
docker run -d --name kutt --restart unless-stopped \
  -p 3016:3000 \
  kutt/kutt:latest
echo "kutt installed."
