#!/usr/bin/env bash
set -e
echo "Installing netdata (Real-time system performance monitoring)..."
docker run -d --name netdata --restart unless-stopped \
  -p 19999:19999 \
  -v netdata-data:/etc/netdata \
  netdata/netdata:latest
echo "netdata installed."
