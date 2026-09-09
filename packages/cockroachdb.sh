#!/usr/bin/env bash
set -e
echo "Installing cockroachdb (Distributed SQL database)..."
docker run -d --name cockroachdb --restart unless-stopped \
  -p 26257:26257 \
  -p 8124:8080 \
  -v cockroachdb-data:/cockroach/cockroach-data \
  cockroachdb/cockroach:latest
echo "cockroachdb installed."
