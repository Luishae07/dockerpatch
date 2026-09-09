#!/usr/bin/env bash
set -e
echo "Installing actualbudget (Personal budgeting app)..."
docker run -d --name actualbudget --restart unless-stopped \
  -p 5006:5006 \
  -v actualbudget-data:/data \
  actualbudget/actual-server:latest
echo "actualbudget installed."
