#!/usr/bin/env bash
set -e
echo "Installing stirling (PDF manipulation toolkit)..."
docker run -d --name stirling --restart unless-stopped \
  -p 8134:8080 \
  frooodle/s-pdf:latest
echo "stirling installed."
