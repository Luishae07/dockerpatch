#!/usr/bin/env bash
set -e
echo "Installing mailcow (Full-featured mail server suite)..."
docker run -d --name mailcow --restart unless-stopped \
  -p 8143:80 \
  mailcow/dockerized:latest
echo "mailcow installed."
