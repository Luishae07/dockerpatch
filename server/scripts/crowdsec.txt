#!/usr/bin/env bash
set -e
echo "Installing crowdsec (Collaborative intrusion detection)..."
docker run -d --name crowdsec --restart unless-stopped \
  -p 8159:8080 \
  -v crowdsec-data:/var/lib/crowdsec \
  crowdsecurity/crowdsec:latest
echo "crowdsec installed."
