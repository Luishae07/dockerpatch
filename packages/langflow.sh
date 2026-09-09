#!/usr/bin/env bash
set -e
echo "Installing langflow (Visual LLM/agent workflow builder)..."
docker run -d --name langflow --restart unless-stopped \
  -p 7860:7860 \
  langflowai/langflow:latest
echo "langflow installed."
