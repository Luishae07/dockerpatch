#!/usr/bin/env bash
set -e
echo "Installing jenkins (CI/CD automation server)..."
docker run -d --name jenkins --restart unless-stopped \
  -p 8086:8080 \
  -v jenkins-data:/var/jenkins_home \
  jenkins/jenkins:lts
echo "jenkins installed."
