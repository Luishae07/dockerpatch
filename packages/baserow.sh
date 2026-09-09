#!/usr/bin/env bash
set -e
echo "Installing baserow (No-code database (Airtable alternative))..."
docker run -d --name baserow --restart unless-stopped \
  -p 8148:80 \
  -v baserow-data:/baserow/data \
  baserow/baserow:latest
echo "baserow installed."
