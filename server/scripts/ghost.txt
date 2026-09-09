#!/usr/bin/env bash
set -e
echo "Installing ghost (Blogging/publishing platform)..."
docker run -d --name ghost --restart unless-stopped \
  -p 2368:2368 \
  -v ghost-data:/var/lib/ghost/content \
  ghost:latest
echo "ghost installed."
