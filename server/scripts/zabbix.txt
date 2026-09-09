#!/usr/bin/env bash
set -e
echo "Installing zabbix (Enterprise network monitoring)..."
docker run -d --name zabbix --restart unless-stopped \
  -p 10051:10051 \
  -v zabbix-data:/var/lib/zabbix \
  zabbix/zabbix-server-pgsql:latest
echo "zabbix installed."
