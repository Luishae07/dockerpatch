#!/usr/bin/env bash
set -e
echo "Installing librespeed (Self-hosted speed test)..."
docker run -d --name librespeed --restart unless-stopped \
  -p 8120:80 \
  -v librespeed-data:/config \
  linuxserver/librespeed:latest
echo "librespeed installed."
