#!/usr/bin/env bash
set -e
echo "Installing superset (Data exploration/visualization)..."
docker run -d --name superset --restart unless-stopped \
  -p 8166:8088 \
  apache/superset:latest
echo "superset installed."
