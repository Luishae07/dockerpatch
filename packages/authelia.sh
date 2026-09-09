#!/usr/bin/env bash
set -e
echo "Installing authelia (Self-hosted SSO/2FA auth server)..."
docker run -d --name authelia --restart unless-stopped \
  -p 9091:9091 \
  -v authelia-data:/config \
  authelia/authelia:latest
echo "authelia installed."
