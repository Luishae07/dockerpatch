#!/usr/bin/env bash
set -e
echo "Installing pgadmin (Postgres admin UI)..."
docker run -d --name pgadmin --restart unless-stopped \
  -p 8162:80 \
  -v pgadmin-data:/var/lib/pgadmin \
  dpage/pgadmin4:latest
echo "pgadmin installed."
