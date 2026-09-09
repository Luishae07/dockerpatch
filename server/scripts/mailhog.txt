#!/usr/bin/env bash
set -e
echo "Installing mailhog (Email testing/dev SMTP catcher)..."
docker run -d --name mailhog --restart unless-stopped \
  -p 8025:8025 \
  mailhog/mailhog:latest
echo "mailhog installed."
