#!/usr/bin/env bash
set -e
echo "Installing codeserver (VS Code in the browser)..."
docker run -d --name codeserver --restart unless-stopped \
  -p 8443:8080 \
  -v codeserver-data:/home/coder/project \
  codercom/code-server:latest
echo "codeserver installed."
