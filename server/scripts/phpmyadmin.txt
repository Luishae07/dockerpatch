#!/usr/bin/env bash
set -e
echo "Installing phpmyadmin (MySQL/MariaDB admin UI)..."
docker run -d --name phpmyadmin --restart unless-stopped \
  -p 8163:80 \
  phpmyadmin:latest
echo "phpmyadmin installed."
