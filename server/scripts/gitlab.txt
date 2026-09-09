#!/usr/bin/env bash
set -e
echo "Installing gitlab (Self-hosted DevOps platform)..."
docker run -d --name gitlab --restart unless-stopped \
  -p 8084:80 \
  -v gitlab-data:/etc/gitlab \
  gitlab/gitlab-ce:latest
echo "gitlab installed."
