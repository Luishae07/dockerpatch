#!/usr/bin/env bash
set -e
echo "Installing prowlarr (Indexer manager for *arr apps)..."
docker run -d --name prowlarr --restart unless-stopped \
  -p 9696:9696 \
  -v prowlarr-data:/config \
  linuxserver/prowlarr:latest
echo "prowlarr installed."
