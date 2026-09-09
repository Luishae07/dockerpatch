#!/usr/bin/env bash
set -e
echo "Installing privatebin (Encrypted pastebin)..."
docker run -d --name privatebin --restart unless-stopped \
  -p 8132:8080 \
  -v privatebin-data:/srv/data \
  privatebin/nginx-fpm-alpine:latest
echo "privatebin installed."
