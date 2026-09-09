#!/usr/bin/env bash
set -e
echo "Installing nagios (Network/infra monitoring)..."
docker run -d --name nagios --restart unless-stopped \
  -p 8156:80 \
  -v nagios-data:/opt/nagios/var \
  jasonrivers/nagios:latest
echo "nagios installed."
