#!/usr/bin/env bash
set -e
echo "Installing couchdb (Document-oriented database)..."
docker run -d --name couchdb --restart unless-stopped \
  -p 5984:5984 \
  -v couchdb-data:/opt/couchdb/data \
  couchdb:latest
echo "couchdb installed."
