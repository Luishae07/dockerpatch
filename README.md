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
   plain-text relative path, e.g. `/scripts/<name>.txt`.
4. It fetches that path from the same server, which returns the install
   script as plain text, and runs it.

## Layout

- `server/` — the Go backend serving `/api/list`, `/api/info/<name>`, and
  `/scripts/<name>.txt`. The catalog data (`packages.json`, the script
  contents) is runtime data on the deployed server's own disk, not part of
  this repository.
- `patch/` — the Go wrapper that replaces `docker` on PATH.

## Installing the patch

```bash
curl -fsSL https://raw.githubusercontent.com/Luishae07/dockerpatch/main/install.sh | bash
```

Now `docker install webui` works, and every other `docker ...` command behaves exactly as before.

## Docs

See [docs.html](https://luishae07.github.io/dockerpatch/docs.html) for the full API reference, self-hosting instructions, and troubleshooting.
