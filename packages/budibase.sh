#!/usr/bin/env bash
set -e
echo "Installing budibase (Low-code app builder)..."
docker run -d --name budibase --restart unless-stopped \
  -p 10000:10000 \
  -v budibase-data:/data \
  budibase/budibase:latest
echo "budibase installed."
