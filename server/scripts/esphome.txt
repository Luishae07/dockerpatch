#!/usr/bin/env bash
set -e
echo "Installing esphome (ESP8266/32 firmware manager)..."
docker run -d --name esphome --restart unless-stopped \
  -p 6052:6052 \
  -v esphome-data:/config \
  esphome/esphome:latest
echo "esphome installed."
