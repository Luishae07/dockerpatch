#!/usr/bin/env bash
set -e
echo "Installing mattermost (Team chat (Slack alternative))..."
docker run -d --name mattermost --restart unless-stopped \
  -p 8108:8065 \
  -v mattermost-data:/mattermost/data \
  mattermost/mattermost-team-edition:latest
echo "mattermost installed."
