#!/usr/bin/env bash
set -e
echo "Installing minio (S3-compatible object storage)..."
docker run -d --name minio --restart unless-stopped \
  -p 9002:9000 \
  -p 9003:9001 \
  -v minio-data:/data \
  minio/minio:latest
echo "minio installed."
