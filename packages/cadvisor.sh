#!/usr/bin/env bash
set -e
echo "Installing cadvisor (Container resource usage monitoring)..."
docker run -d --name cadvisor --restart unless-stopped \
  -p 8117:8080 \
  gcr.io/cadvisor/cadvisor:latest
echo "cadvisor installed."
