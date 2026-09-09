#!/usr/bin/env bash
set -e
echo "Installing grafana (Metrics dashboards)..."
docker run -d --name grafana --restart unless-stopped \
  -p 3002:3000 \
  -v grafana-data:/var/lib/grafana \
  grafana/grafana:latest
echo "grafana installed."
