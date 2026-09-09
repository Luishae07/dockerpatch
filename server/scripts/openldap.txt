#!/usr/bin/env bash
set -e
echo "Installing openldap (LDAP directory server)..."
docker run -d --name openldap --restart unless-stopped \
  -p 389:389 \
  -v openldap-data:/var/lib/ldap \
  osixia/openldap:latest
echo "openldap installed."
