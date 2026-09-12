// dockerpatch server — serves the package catalog (/api/list), per-package
// info endpoints (/api/info/<name>), and the actual install script text
// files (/scripts/<name>.txt) itself. The "docker install" wrapper fetches
// the catalog, then the info URL, then the script text, and runs it.
package main

import (
	"crypto/sha256"
	"encoding/hex"
	"encoding/json"
	"log"
	"net/http"
	"os"
	"path/filepath"
	"regexp"
	"strings"
	"sync"
)

type catalogEntry struct {
	Name        string `json:"name"`
	Description string `json:"description"`
	Script      string `json:"script"` // relative path in the repo, e.g. "packages/webui.sh"
}

type Package struct {
	Name        string `json:"name"`
	Description string `json:"description"`
	InstallID   string `json:"install_id"`
	InfoURL     string `json:"info_url"` // relative path on this server; GET returns plain-text script URL
	scriptURL   string // also relative to this server, e.g. "/scripts/webui.txt"
}

var (
	catalogMu   sync.RWMutex
	packages    = map[string]*Package{}
	catalogPath = "packages.json"
)

var scriptsBundlePath = "scripts_bundle.json"

var (
	scriptsMu sync.RWMutex
	scripts   = map[string]string{}
)

// loadScripts re-reads scripts_bundle.json from disk and atomically swaps
// it in — same hot-reload pattern as loadCatalog, so ghsearch-added scripts
// show up without a restart.
func loadScripts() error {
	f, err := os.Open(scriptsBundlePath)
	if err != nil {
		return err
	}
	defer f.Close()

	var fresh map[string]string
	if err := json.NewDecoder(f).Decode(&fresh); err != nil {
		return err
	}

	scriptsMu.Lock()
	scripts = fresh
	scriptsMu.Unlock()
	return nil
}

// genID is deterministic (derived from the package name) so install-ids
// stay stable across server restarts instead of changing every time.
func genID(name string) string {
	sum := sha256.Sum256([]byte(name))
	return hex.EncodeToString(sum[:8])
}

// loadCatalog re-reads packages.json from disk and atomically swaps it in.
// Called on every request (not just at startup) so newly-added packages
// (e.g. from ghsearch) show up immediately without restarting the server.
func loadCatalog() error {
	f, err := os.Open(catalogPath)
	if err != nil {
		return err
	}
	defer f.Close()

	var entries []catalogEntry
	if err := json.NewDecoder(f).Decode(&entries); err != nil {
		return err
	}

	fresh := make(map[string]*Package, len(entries))
	for _, e := range entries {
		fresh[e.Name] = &Package{
			Name:        e.Name,
			Description: e.Description,
			InstallID:   genID(e.Name),
			InfoURL:     "/api/info/" + e.Name,
			scriptURL:   "/scripts/" + e.Name + ".txt",
		}
	}

	catalogMu.Lock()
	packages = fresh
	catalogMu.Unlock()
	return nil
}

func handleList(w http.ResponseWriter, r *http.Request) {
	if err := loadCatalog(); err != nil {
		log.Printf("reload failed, serving stale catalog: %v", err)
	}
	catalogMu.RLock()
	list := make([]*Package, 0, len(packages))
	for _, p := range packages {
		list = append(list, p)
	}
	catalogMu.RUnlock()
	w.Header().Set("Content-Type", "application/json")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	json.NewEncoder(w).Encode(list)
}

func handleInfo(w http.ResponseWriter, r *http.Request) {
	if err := loadCatalog(); err != nil {
		log.Printf("reload failed, serving stale catalog: %v", err)
	}
	name := r.URL.Path[len("/api/info/"):]
	catalogMu.RLock()
	p, ok := packages[name]
	catalogMu.RUnlock()
	if !ok {
		http.Error(w, "package not found", http.StatusNotFound)
		return
	}
	w.Header().Set("Content-Type", "text/plain")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.Write([]byte(p.scriptURL))
}

func handleScript(w http.ResponseWriter, r *http.Request) {
	name := r.URL.Path[len("/scripts/"):]
	// name arrives as "<pkg>.txt" — strip to the bare package name and
	// re-validate against the catalog so we never serve arbitrary entries.
	base := name
	if ext := filepath.Ext(base); ext == ".txt" {
		base = base[:len(base)-len(ext)]
	}
	catalogMu.RLock()
	_, ok := packages[base]
	catalogMu.RUnlock()
	if !ok {
		http.Error(w, "script not found", http.StatusNotFound)
		return
	}

	if err := loadScripts(); err != nil {
		log.Printf("reload failed, serving stale scripts: %v", err)
	}
	scriptsMu.RLock()
	content, ok := scripts[base]
	scriptsMu.RUnlock()
	if !ok {
		http.Error(w, "script not found", http.StatusNotFound)
		return
	}

	w.Header().Set("Content-Type", "text/plain")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.Write([]byte(content))
}

// submitRequest is what the "submit your repo" page (submit.html) posts
// after the user has confirmed the extracted docker run command is theirs
// and correct.
type submitRequest struct {
	Name        string `json:"name"`
	Description string `json:"description"`
	Script      string `json:"script"` // the full script text, incl. the real "docker run ..." block
	Source      string `json:"source"` // e.g. "owner/repo", for provenance only
}

var nameRe = regexp.MustCompile(`^[a-z0-9][a-z0-9-]{1,63}$`)

func handleSubmit(w http.ResponseWriter, r *http.Request) {
	// CORS header must be set before the method check — the browser sends
	// an OPTIONS preflight ahead of the real POST (since Content-Type:
	// application/json isn't a "simple" header), and that preflight needs
	// this header on its response or the whole request gets blocked
	// client-side before the POST is ever sent.
	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.Header().Set("Access-Control-Allow-Methods", "POST, OPTIONS")
	w.Header().Set("Access-Control-Allow-Headers", "Content-Type")
	if r.Method == http.MethodOptions {
		return
	}
	if r.Method != http.MethodPost {
		http.Error(w, "POST only", http.StatusMethodNotAllowed)
		return
	}

	var req submitRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		http.Error(w, "bad json", http.StatusBadRequest)
		return
	}
	req.Name = strings.ToLower(strings.TrimSpace(req.Name))
	if !nameRe.MatchString(req.Name) {
		http.Error(w, "invalid name (lowercase letters/digits/hyphens, 2-64 chars)", http.StatusBadRequest)
		return
	}
	if !strings.Contains(req.Script, "docker run") {
		http.Error(w, "script must contain a real 'docker run' command", http.StatusBadRequest)
		return
	}
	if len(req.Script) > 20000 {
		http.Error(w, "script too large", http.StatusBadRequest)
		return
	}

	if err := loadCatalog(); err != nil {
		log.Printf("reload failed before submit: %v", err)
	}
	catalogMu.RLock()
	_, taken := packages[req.Name]
	catalogMu.RUnlock()
	if taken {
		http.Error(w, "a package with that name already exists", http.StatusConflict)
		return
	}

	// Append to packages.json on disk.
	f, err := os.Open(catalogPath)
	if err != nil {
		http.Error(w, "server error reading catalog", http.StatusInternalServerError)
		return
	}
	var entries []catalogEntry
	err = json.NewDecoder(f).Decode(&entries)
	f.Close()
	if err != nil {
		http.Error(w, "server error decoding catalog", http.StatusInternalServerError)
		return
	}
	desc := req.Description
	if desc == "" {
		desc = "Submitted via dockerpatch (" + req.Source + ")"
	}
	entries = append(entries, catalogEntry{
		Name:        req.Name,
		Description: desc,
		Script:      "packages/" + req.Name + ".sh",
	})
	out, err := os.Create(catalogPath)
	if err != nil {
		http.Error(w, "server error writing catalog", http.StatusInternalServerError)
		return
	}
	enc := json.NewEncoder(out)
	enc.SetIndent("", "  ")
	enc.Encode(entries)
	out.Close()

	// Append to scripts_bundle.json on disk.
	sf, err := os.Open(scriptsBundlePath)
	if err != nil {
		http.Error(w, "server error reading scripts bundle", http.StatusInternalServerError)
		return
	}
	var bundle map[string]string
	err = json.NewDecoder(sf).Decode(&bundle)
	sf.Close()
	if err != nil {
		http.Error(w, "server error decoding scripts bundle", http.StatusInternalServerError)
		return
	}
	bundle[req.Name] = req.Script
	sout, err := os.Create(scriptsBundlePath)
	if err != nil {
		http.Error(w, "server error writing scripts bundle", http.StatusInternalServerError)
		return
	}
	json.NewEncoder(sout).Encode(bundle)
	sout.Close()

	loadCatalog()
	loadScripts()

	log.Printf("submitted new package: %s (from %s)", req.Name, req.Source)
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(map[string]string{"status": "ok", "install_id": genID(req.Name)})
}

func main() {
	if v := os.Getenv("DOCKERPATCH_CATALOG"); v != "" {
		catalogPath = v
	}
	if err := loadCatalog(); err != nil {
		log.Fatalf("failed to load catalog from %s: %v", catalogPath, err)
	}
	log.Printf("loaded %d packages from %s (reloaded on every request)", len(packages), catalogPath)

	if v := os.Getenv("DOCKERPATCH_SCRIPTS_BUNDLE"); v != "" {
		scriptsBundlePath = v
	}
	if err := loadScripts(); err != nil {
		log.Fatalf("failed to load scripts bundle from %s: %v", scriptsBundlePath, err)
	}
	log.Printf("loaded %d scripts from %s (reloaded on every request)", len(scripts), scriptsBundlePath)

	port := os.Getenv("PORT")
	if port == "" {
		port = "8940"
	}

	http.HandleFunc("/api/list", handleList)
	http.HandleFunc("/api/info/", handleInfo)
	http.HandleFunc("/scripts/", handleScript)
	http.HandleFunc("/api/submit", handleSubmit)

	log.Printf("dockerpatch server listening on :%s", port)
	log.Fatal(http.ListenAndServe(":"+port, nil))
}
