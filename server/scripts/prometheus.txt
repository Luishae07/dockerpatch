#!/usr/bin/env bash
set -e
echo "Installing prometheus (Metrics collection/monitoring)..."
docker run -d --name prometheus --restart unless-stopped \
  -p 9090:9090 \
  -v prometheus-data:/prometheus \
  prom/prometheus:latest
echo "prometheus installed."
