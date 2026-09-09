#!/usr/bin/env bash
set -e
echo "Installing glances (System monitoring dashboard)..."
docker run -d --name glances --restart unless-stopped \
  -p 61208:61208 \
  nicolargo/glances:latest
echo "glances installed."
