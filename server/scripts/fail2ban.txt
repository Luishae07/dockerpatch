#!/usr/bin/env bash
set -e
echo "Installing fail2ban (Intrusion prevention (bans malicious IPs))..."
docker run -d --name fail2ban --restart unless-stopped \
  crazymax/fail2ban:latest
echo "fail2ban installed."
