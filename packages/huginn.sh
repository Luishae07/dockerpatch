#!/usr/bin/env bash
set -e
echo "Installing huginn (Automation/agent-based workflow tool)..."
docker run -d --name huginn --restart unless-stopped \
  -p 3020:3000 \
  huginn/huginn:latest
echo "huginn installed."
