#!/usr/bin/env bash
set -e
echo "Installing clickhouse (Columnar analytics database)..."
docker run -d --name clickhouse --restart unless-stopped \
  -p 8125:8123 \
  -v clickhouse-data:/var/lib/clickhouse \
  clickhouse/clickhouse-server:latest
echo "clickhouse installed."
