#!/usr/bin/env bash
set -e
echo "Installing nocodb (No-code database platform)..."
docker run -d --name nocodb --restart unless-stopped \
  -p 8149:8080 \
  -v nocodb-data:/usr/app/data \
  nocodb/nocodb:latest
echo "nocodb installed."
