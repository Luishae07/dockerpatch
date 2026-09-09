#!/usr/bin/env bash
set -e
echo "Installing syncthing (Continuous file sync between devices)..."
docker run -d --name syncthing --restart unless-stopped \
  -p 8384:8384 \
  -v syncthing-data:/var/syncthing \
  syncthing/syncthing:latest
echo "syncthing installed."
