#!/usr/bin/env bash
set -e
echo "Installing poste (All-in-one mail server)..."
docker run -d --name poste --restart unless-stopped \
  -p 8144:80 \
  -v poste-data:/data \
  analogic/poste.io:latest
echo "poste installed."
