#!/usr/bin/env bash
set -e
echo "Installing sonarqube (Code quality/static analysis)..."
docker run -d --name sonarqube --restart unless-stopped \
  -p 9001:9000 \
  -v sonarqube-data:/opt/sonarqube/data \
  sonarqube:latest
echo "sonarqube installed."
