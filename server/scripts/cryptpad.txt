#!/usr/bin/env bash
set -e
echo "Installing cryptpad (Encrypted collaborative office suite)..."
docker run -d --name cryptpad --restart unless-stopped \
  -p 3017:3000 \
  -v cryptpad-data:/cryptpad/blob \
  cryptpad/cryptpad:latest
echo "cryptpad installed."
