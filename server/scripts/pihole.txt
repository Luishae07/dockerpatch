#!/usr/bin/env bash
set -e
echo "Installing pihole (Network-wide ad blocker/DNS)..."
docker run -d --name pihole --restart unless-stopped \
  -p 53:53 \
  -p 8080:80 \
  -v pihole-data:/etc/pihole \
  pihole/pihole:latest
echo "pihole installed."
