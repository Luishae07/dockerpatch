#!/usr/bin/env bash
set -e
echo "Installing checkmk (IT infrastructure monitoring)..."
docker run -d --name checkmk --restart unless-stopped \
  -p 8157:5000 \
  -v checkmk-data:/omd/sites \
  checkmk/check-mk-raw:latest
echo "checkmk installed."
