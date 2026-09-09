#!/usr/bin/env bash
set -e
echo "Installing chatwoot (Customer support/live chat)..."
docker run -d --name chatwoot --restart unless-stopped \
  -p 3019:3000 \
  chatwoot/chatwoot:latest
echo "chatwoot installed."
