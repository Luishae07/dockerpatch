#!/usr/bin/env bash
set -e
echo "Installing joplin (Note sync server for Joplin app)..."
docker run -d --name joplin --restart unless-stopped \
  -p 22300:22300 \
  florider89/joplin-server:latest
echo "joplin installed."
