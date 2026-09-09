// dockerpatch wrapper - replaces the docker binary on PATH. Intercepts
// "docker install <name>" and handles it; every other subcommand is
// forwarded untouched to the real docker binary, so this works
// transparently regardless of installed Docker CLI version.
package main

import (
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
	"syscall"
)

const tunnelURLPageURL = "https://luishae07.github.io/dockerpatch/tunnel-url.txt"

// The real docker binary always lives next to this wrapper, named
// "docker-real" (that's where install.sh puts it) - resolved relative to
// our own executable path so this works regardless of where docker is
// installed (/usr/bin, OrbStack's ~/.orbstack/bin, Homebrew, etc.),
// unless overridden explicitly via DOCKERPATCH_REAL_DOCKER.
func resolveRealDockerPath() string {
	if v := os.Getenv("DOCKERPATCH_REAL_DOCKER"); v != "" {
		return v
	}
	self, err := os.Executable()
	if err != nil {
		return "/usr/bin/docker-real"
	}
	self, err = filepath.EvalSymlinks(self)
	if err != nil {
		return "/usr/bin/docker-real"
	}
	return filepath.Join(filepath.Dir(self), "docker-real")
}

var realDockerPath = resolveRealDockerPath()

type pkgEntry struct {
	Name      string `json:"name"`
	InstallID string `json:"install_id"`
	InfoURL   string `json:"info_url"`
}

func fetch(url string) (string, error) {
	resp, err := http.Get(url)
	if err != nil {
		return "", err
	}
	defer resp.Body.Close()
	if resp.StatusCode != 200 {
		return "", fmt.Errorf("HTTP %d from %s", resp.StatusCode, url)
	}
	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return "", err
	}
	return strings.TrimSpace(string(body)), nil
}

func doInstall(name string) error {
	fmt.Printf("dockerpatch: resolving tunnel URL...\n")
	tunnelURL, err := fetch(tunnelURLPageURL)
	if err != nil {
		return fmt.Errorf("could not reach %s: %w", tunnelURLPageURL, err)
	}
	tunnelURL = strings.TrimRight(tunnelURL, "/")

	fmt.Printf("dockerpatch: fetching package list from %s...\n", tunnelURL)
	listBody, err := fetch(tunnelURL + "/api/list")
	if err != nil {
		return fmt.Errorf("could not reach dockerpatch server: %w", err)
	}

	var pkgs []pkgEntry
	if err := json.Unmarshal([]byte(listBody), &pkgs); err != nil {
		return fmt.Errorf("bad package list from server: %w", err)
	}

	var match *pkgEntry
	for i := range pkgs {
		if pkgs[i].Name == name {
			match = &pkgs[i]
			break
		}
	}
	if match == nil {
		fmt.Printf("dockerpatch: package %q not found. Available:\n", name)
		for _, p := range pkgs {
			fmt.Printf("  - %s\n", p.Name)
		}
		return fmt.Errorf("unknown package")
	}
	fmt.Printf("dockerpatch: found %s (install-id %s)\n", match.Name, match.InstallID)

	scriptURL, err := fetch(tunnelURL + match.InfoURL)
	if err != nil {
		return fmt.Errorf("could not fetch package info: %w", err)
	}
	// scriptURL is relative to the dockerpatch server (e.g. "/scripts/webui.txt")
	if !strings.HasPrefix(scriptURL, "http://") && !strings.HasPrefix(scriptURL, "https://") {
		scriptURL = tunnelURL + scriptURL
	}
	fmt.Printf("dockerpatch: downloading install script from %s...\n", scriptURL)

	script, err := fetch(scriptURL)
	if err != nil {
		return fmt.Errorf("could not download install script: %w", err)
	}

	fmt.Printf("dockerpatch: running install script for %s...\n", match.Name)
	cmd := exec.Command("bash", "-c", script)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	cmd.Stdin = os.Stdin
	return cmd.Run()
}

func main() {
	args := os.Args[1:]

	if len(args) >= 1 && args[0] == "install" {
		if len(args) < 2 {
			fmt.Fprintln(os.Stderr, "usage: docker install <package-name>")
			os.Exit(1)
		}
		if err := doInstall(args[1]); err != nil {
			fmt.Fprintf(os.Stderr, "dockerpatch: %v\n", err)
			os.Exit(1)
		}
		return
	}

	// Not our subcommand - hand off to the real docker binary, replacing
	// this process entirely (exec, not spawn) so exit codes/signals/stdio
	// behave exactly as if the real docker had been called directly.
	err := syscall.Exec(realDockerPath, append([]string{realDockerPath}, args...), os.Environ())
	if err != nil {
		fmt.Fprintf(os.Stderr, "dockerpatch: failed to exec real docker at %s: %v\n", realDockerPath, err)
		os.Exit(1)
	}
}
