#!/usr/bin/env bash
set -e
echo "Installing standardnotes (End-to-end encrypted notes)..."
docker run -d --name standardnotes --restart unless-stopped \
  -p 3007:3000 \
  standardnotes/server:latest
echo "standardnotes installed."
