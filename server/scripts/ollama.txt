#!/usr/bin/env bash
set -e
echo "Installing ollama (Local LLM runner)..."
docker run -d --name ollama --restart unless-stopped \
  -p 11434:11434 \
  -v ollama-data:/root/.ollama \
  ollama/ollama:latest
echo "ollama installed."
