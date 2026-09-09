#!/usr/bin/env bash
set -e
echo "Installing wallabaghome (Read-it-later app (alt image))..."
docker run -d --name wallabaghome --restart unless-stopped \
  -p 8141:80 \
  -v wallabaghome-data:/config \
  linuxserver/wallabag:latest
echo "wallabaghome installed."
