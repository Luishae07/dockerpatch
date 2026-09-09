#!/usr/bin/env bash
set -e
echo "Installing mysql (Relational database)..."
docker run -d --name mysql --restart unless-stopped \
  -p 3306:3306 \
  -v mysql-data:/var/lib/mysql \
  mysql:latest
echo "mysql installed."
