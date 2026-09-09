#!/usr/bin/env bash
set -e
echo "Installing mariadb (Relational database (MySQL fork))..."
docker run -d --name mariadb --restart unless-stopped \
  -p 3307:3306 \
  -v mariadb-data:/var/lib/mysql \
  mariadb:latest
echo "mariadb installed."
