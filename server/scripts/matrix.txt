#!/usr/bin/env bash
set -e
echo "Installing matrix (Matrix homeserver (federated chat))..."
docker run -d --name matrix --restart unless-stopped \
  -p 8448:8448 \
  -v matrix-data:/data \
  matrixdotorg/synapse:latest
echo "matrix installed."
