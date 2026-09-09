#!/usr/bin/env bash
set -e
echo "Installing registry (Private Docker image registry)..."
docker run -d --name registry --restart unless-stopped \
  -p 5000:5000 \
  -v registry-data:/var/lib/registry \
  registry:2
echo "registry installed."
