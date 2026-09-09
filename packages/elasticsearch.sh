#!/usr/bin/env bash
set -e
echo "Installing elasticsearch (Search/analytics engine)..."
docker run -d --name elasticsearch --restart unless-stopped \
  -p 9200:9200 \
  -v elasticsearch-data:/usr/share/elasticsearch/data \
  elasticsearch:8.15.0
echo "elasticsearch installed."
