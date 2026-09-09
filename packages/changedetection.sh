#!/usr/bin/env bash
set -e
echo "Installing changedetection (Website change detection)..."
docker run -d --name changedetection --restart unless-stopped \
  -p 5000:5000 \
  -v changedetection-data:/datastore \
  ghcr.io/dgtlmoon/changedetection.io:latest
echo "changedetection installed."
