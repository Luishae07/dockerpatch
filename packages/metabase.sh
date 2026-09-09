#!/usr/bin/env bash
set -e
echo "Installing metabase (Business intelligence/dashboards)..."
docker run -d --name metabase --restart unless-stopped \
  -p 3023:3000 \
  -v metabase-data:/metabase-data \
  metabase/metabase:latest
echo "metabase installed."
