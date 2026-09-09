#!/usr/bin/env bash
set -e
echo "Installing neo4j (Graph database)..."
docker run -d --name neo4j --restart unless-stopped \
  -p 7474:7474 \
  -p 7687:7687 \
  -v neo4j-data:/data \
  neo4j:latest
echo "neo4j installed."
