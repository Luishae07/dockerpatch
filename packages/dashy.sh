#!/usr/bin/env bash
set -e
echo "Installing dashy (Self-hosted start page/dashboard)..."
docker run -d --name dashy --restart unless-stopped \
  -p 4001:80 \
  -v dashy-data:/app/user-data \
  lissy93/dashy:latest
echo "dashy installed."
