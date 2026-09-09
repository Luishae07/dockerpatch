#!/usr/bin/env bash
set -e
echo "Installing redisinsight (Redis GUI/admin tool)..."
docker run -d --name redisinsight --restart unless-stopped \
  -p 5540:5540 \
  -v redisinsight-data:/data \
  redis/redisinsight:latest
echo "redisinsight installed."
