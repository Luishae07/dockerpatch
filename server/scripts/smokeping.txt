#!/usr/bin/env bash
set -e
echo "Installing smokeping (Network latency monitoring)..."
docker run -d --name smokeping --restart unless-stopped \
  -p 8158:80 \
  -v smokeping-data:/config \
  linuxserver/smokeping:latest
echo "smokeping installed."
