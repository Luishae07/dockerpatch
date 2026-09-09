#!/usr/bin/env bash
set -e
echo "Installing kavita (Ebook/comic reading server)..."
docker run -d --name kavita --restart unless-stopped \
  -p 5007:5000 \
  -v kavita-data:/kavita/config \
  kizaing/kavita:latest
echo "kavita installed."
