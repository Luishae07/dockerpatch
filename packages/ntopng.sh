#!/usr/bin/env bash
set -e
echo "Installing ntopng (Network traffic monitoring)..."
docker run -d --name ntopng --restart unless-stopped \
  -p 3022:3000 \
  jonaslejon/ntopng:latest
echo "ntopng installed."
