#!/usr/bin/env bash
set -e
echo "Installing postgres (Relational database)..."
docker run -d --name postgres --restart unless-stopped \
  -p 5432:5432 \
  -v postgres-data:/var/lib/postgresql/data \
  postgres:latest
echo "postgres installed."
