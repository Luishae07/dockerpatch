#!/usr/bin/env bash
set -e
echo "Installing authentik (Identity provider/SSO platform)..."
docker run -d --name authentik --restart unless-stopped \
  -p 9002:9000 \
  -v authentik-data:/media \
  ghcr.io/goauthentik/server:latest
echo "authentik installed."
