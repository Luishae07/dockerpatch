#!/usr/bin/env bash
set -e
echo "Installing bigbluebutton (Web conferencing for online learning)..."
docker run -d --name bigbluebutton --restart unless-stopped \
  -p 8110:80 \
  bigbluebutton/bbb-web:latest
echo "bigbluebutton installed."
