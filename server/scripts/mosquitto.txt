#!/usr/bin/env bash
set -e
echo "Installing mosquitto (MQTT message broker)..."
docker run -d --name mosquitto --restart unless-stopped \
  -p 1883:1883 \
  -v mosquitto-data:/mosquitto/data \
  eclipse-mosquitto:latest
echo "mosquitto installed."
