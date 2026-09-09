#!/usr/bin/env bash
set -e
echo "Installing appsmith (Low-code app builder)..."
docker run -d --name appsmith --restart unless-stopped \
  -p 8150:80 \
  -v appsmith-data:/appsmith-stacks \
  appsmith/appsmith-ce:latest
echo "appsmith installed."
