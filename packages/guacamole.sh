#!/usr/bin/env bash
set -e
echo "Installing guacamole (Remote desktop gateway (RDP/VNC/SSH in browser))..."
docker run -d --name guacamole --restart unless-stopped \
  -p 8093:8080 \
  guacamole/guacamole:latest
echo "guacamole installed."
