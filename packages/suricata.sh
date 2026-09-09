#!/usr/bin/env bash
set -e
echo "Installing suricata (Network threat detection engine)..."
docker run -d --name suricata --restart unless-stopped \
  -v suricata-data:/var/log/suricata \
  jasonish/suricata:latest
echo "suricata installed."
