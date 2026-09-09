#!/usr/bin/env bash
set -e
echo "Installing mailu (Self-hosted mail server suite)..."
docker run -d --name mailu --restart unless-stopped \
  -p 8142:80 \
  mailu/front:latest
echo "mailu installed."
