#!/usr/bin/env bash
set -e
echo "Installing opensearch (Search/analytics engine (Elastic fork))..."
docker run -d --name opensearch --restart unless-stopped \
  -p 9201:9200 \
  -v opensearch-data:/usr/share/opensearch/data \
  opensearchproject/opensearch:latest
echo "opensearch installed."
