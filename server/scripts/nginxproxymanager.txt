#!/usr/bin/env bash
set -e
echo "Installing nginxproxymanager (Nginx reverse proxy with UI)..."
docker run -d --name nginxproxymanager --restart unless-stopped \
  -p 81:81 \
  -p 80:80 \
  -p 443:443 \
  -v nginxproxymanager-data:/data \
  jc21/nginx-proxy-manager:latest
echo "nginxproxymanager installed."
