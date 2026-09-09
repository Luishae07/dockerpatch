#!/usr/bin/env bash
# dockerpatch installer — patches the docker CLI to add `docker install <name>`.
# Every other docker command keeps working exactly as before; this only
# swaps the binary docker resolves to, backing up the original first.
set -e

DOCKER_PATH="$(command -v docker || true)"
if [[ -z "$DOCKER_PATH" ]]; then
  echo "dockerpatch: no 'docker' found on PATH — install Docker first." >&2
  exit 1
fi

REAL_BACKUP="$(dirname "$DOCKER_PATH")/docker-real"

if ! command -v go >/dev/null 2>&1; then
  echo "dockerpatch: Go toolchain required to build the wrapper — install Go first." >&2
  exit 1
fi

BUILD_DIR="$(mktemp -d)"
trap 'rm -rf "$BUILD_DIR"' EXIT

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ -f "$SCRIPT_DIR/patch/main.go" ]]; then
  cp "$SCRIPT_DIR/patch/main.go" "$SCRIPT_DIR/patch/go.mod" "$BUILD_DIR/"
else
  echo "dockerpatch: fetching wrapper source..."
  curl -fsSL -o "$BUILD_DIR/main.go" https://raw.githubusercontent.com/Luishae07/dockerpatch/main/patch/main.go
  curl -fsSL -o "$BUILD_DIR/go.mod" https://raw.githubusercontent.com/Luishae07/dockerpatch/main/patch/go.mod
fi

echo "dockerpatch: building wrapper..."
( cd "$BUILD_DIR" && go build -o docker-patched main.go )

if [[ -f "$REAL_BACKUP" ]]; then
  echo "dockerpatch: already installed (found $REAL_BACKUP) — replacing wrapper only, backup untouched."
  # docker currently IS the wrapper (or something) — rename it out of the way
  # via mv (not cp) since the running binary may be busy, then install fresh.
  mv "$DOCKER_PATH" "${DOCKER_PATH}.old" 2>/dev/null || true
else
  echo "dockerpatch: backing up real docker to $REAL_BACKUP"
  mv "$DOCKER_PATH" "$REAL_BACKUP"
fi

cp "$BUILD_DIR/docker-patched" "$DOCKER_PATH"
chmod +x "$DOCKER_PATH"
rm -f "${DOCKER_PATH}.old"

echo "dockerpatch: installed. Try: docker install webui"
echo "dockerpatch: to revert, run: mv $REAL_BACKUP $DOCKER_PATH"
