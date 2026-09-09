#!/usr/bin/env bash
set -e
echo "Installing zigbee2mqtt (Zigbee to MQTT bridge)..."
docker run -d --name zigbee2mqtt --restart unless-stopped \
  -p 8091:8080 \
  -v zigbee2mqtt-data:/app/data \
  koenkk/zigbee2mqtt:latest
echo "zigbee2mqtt installed."
