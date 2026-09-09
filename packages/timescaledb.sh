#!/usr/bin/env bash
set -e
echo "Installing timescaledb (Time-series Postgres extension)..."
docker run -d --name timescaledb --restart unless-stopped \
  -p 5433:5432 \
  -v timescaledb-data:/var/lib/postgresql/data \
  timescale/timescaledb:latest-pg16
echo "timescaledb installed."
