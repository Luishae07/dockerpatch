#!/usr/bin/env bash
set -e
echo "Installing flowise (Visual LLM app builder)..."
docker run -d --name flowise --restart unless-stopped \
  -p 3015:3000 \
  -v flowise-data:/root/.flowise \
  flowiseai/flowise:latest
echo "flowise installed."
