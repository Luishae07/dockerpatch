#!/usr/bin/env bash
set -e
echo "Installing onlyoffice (Online office document editor)..."
docker run -d --name onlyoffice --restart unless-stopped \
  -p 8133:80 \
  -v onlyoffice-data:/var/www/onlyoffice/Data \
  onlyoffice/documentserver:latest
echo "onlyoffice installed."
