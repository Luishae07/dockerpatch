#!/usr/bin/env bash
set -e
echo "Installing freescout (Free helpdesk/shared inbox)..."
docker run -d --name freescout --restart unless-stopped \
  -p 8145:80 \
  -v freescout-data:/var/www/html \
  freescout/freescout:latest
echo "freescout installed."
