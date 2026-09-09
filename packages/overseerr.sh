#!/usr/bin/env bash
set -e
echo "Installing overseerr (Media request management)..."
docker run -d --name overseerr --restart unless-stopped \
  -p 5055:5055 \
  -v overseerr-data:/app/config \
  sctx/overseerr:latest
echo "overseerr installed."
