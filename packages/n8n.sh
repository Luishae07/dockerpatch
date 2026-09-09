#!/usr/bin/env bash
set -e
echo "Installing n8n (Workflow automation)..."
docker run -d --name n8n --restart unless-stopped \
  -p 5678:5678 \
  -v n8n-data:/home/node/.n8n \
  n8nio/n8n:latest
echo "n8n installed."
