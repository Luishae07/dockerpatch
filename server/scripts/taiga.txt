#!/usr/bin/env bash
set -e
echo "Installing taiga (Agile project management)..."
docker run -d --name taiga --restart unless-stopped \
  -p 8106:8000 \
  taigaio/taiga-back:latest
echo "taiga installed."
