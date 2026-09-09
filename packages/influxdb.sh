#!/usr/bin/env bash
set -e
echo "Installing influxdb (Time-series database)..."
docker run -d --name influxdb --restart unless-stopped \
  -p 8086:8086 \
  -v influxdb-data:/var/lib/influxdb2 \
  influxdb:latest
echo "influxdb installed."
