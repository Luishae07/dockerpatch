#!/usr/bin/env bash
set -e
echo "Installing audiobookshelf (Audiobook/podcast server)..."
docker run -d --name audiobookshelf --restart unless-stopped \
  -p 13378:80 \
  -v audiobookshelf-data:/config \
  advplyr/audiobookshelf:latest
echo "audiobookshelf installed."
