#!/usr/bin/env bash
set -e
echo "Installing healthchecks (Cron job monitoring)..."
docker run -d --name healthchecks --restart unless-stopped \
  -p 8094:8000 \
  -v healthchecks-data:/config \
  linuxserver/healthchecks:latest
echo "healthchecks installed."
