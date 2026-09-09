#!/usr/bin/env bash
set -e
echo "Installing vaultwarden (Self-hosted Bitwarden-compatible password manager)..."
docker run -d --name vaultwarden --restart unless-stopped \
  -p 8222:80 \
  -v vaultwarden-data:/data \
  vaultwarden/server:latest
echo "vaultwarden installed."
