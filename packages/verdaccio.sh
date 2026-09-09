#!/usr/bin/env bash
set -e
echo "Installing verdaccio (Private npm registry)..."
docker run -d --name verdaccio --restart unless-stopped \
  -p 4873:4873 \
  -v verdaccio-data:/verdaccio \
  verdaccio/verdaccio:latest
echo "verdaccio installed."
