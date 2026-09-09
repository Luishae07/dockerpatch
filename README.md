# dockerpatch

A patch for the `docker` CLI that adds `docker install <name>` — a real package
manager for Docker apps, not a new tool. It intercepts only the `install`
subcommand; every other `docker` command passes straight through to the real
binary, so it works transparently regardless of your installed Docker version.

## How it works

1. `docker install <name>` fetches [`tunnel-url.txt`](tunnel-url.txt) from this
   page (GitHub Pages), which points at the current live dockerpatch server.
2. It calls `<tunnel>/api/list` on that server, which returns a JSON catalog of
   packages: `{name, install_id, info_url}`.
3. It fetches `<tunnel><info_url>` for the matching package, which returns a
   plain-text URL — a raw GitHub link to the actual install script.
4. It downloads that script and runs it.

## Layout

- `server/` — the Go backend serving `/api/list` and `/api/info/<name>`
- `patch/` — the Go wrapper that replaces `docker` on PATH
- `packages/` — the actual install scripts referenced by the catalog

## Installing the patch

```bash
cd patch
go build -o docker-patched main.go
sudo mv /usr/bin/docker /usr/bin/docker-real
sudo mv docker-patched /usr/bin/docker
```

Now `docker install webui` works, and every other `docker ...` command behaves exactly as before.
