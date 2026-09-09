#!/usr/bin/env bash
set -e
echo "Installing listmonk (Newsletter/mailing list manager)..."
docker run -d --name listmonk --restart unless-stopped \
  -p 9010:9000 \
  listmonk/listmonk:latest
echo "listmonk installed."
