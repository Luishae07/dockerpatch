#!/usr/bin/env bash
set -e
echo "Installing keycloak (Identity and access management)..."
docker run -d --name keycloak --restart unless-stopped \
  -p 8160:8080 \
  quay.io/keycloak/keycloak:latest
echo "keycloak installed."
