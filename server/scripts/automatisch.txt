#!/usr/bin/env bash
set -e
echo "Installing automatisch (Workflow automation (Zapier alternative))..."
docker run -d --name automatisch --restart unless-stopped \
  -p 3021:3000 \
  automatisch/automatisch:latest
echo "automatisch installed."
