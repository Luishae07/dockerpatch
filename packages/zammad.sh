#!/usr/bin/env bash
set -e
echo "Installing zammad (Helpdesk/customer support)..."
docker run -d --name zammad --restart unless-stopped \
  -p 8146:8080 \
  zammad/zammad-docker-compose:latest
echo "zammad installed."
