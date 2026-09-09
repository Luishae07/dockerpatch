#!/usr/bin/env bash
set -e
echo "Installing homeassistant (Home automation platform)..."
docker run -d --name homeassistant --restart unless-stopped \
  -p 8123:8123 \
  -v homeassistant-data:/config \
  homeassistant/home-assistant:stable
echo "homeassistant installed."
