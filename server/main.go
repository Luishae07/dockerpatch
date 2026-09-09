// dockerpatch server — serves the package catalog (/api/list), per-package
// info endpoints (/api/info/<name>), and the actual install script text
// files (/scripts/<name>.txt) itself. The "docker install" wrapper fetches
// the catalog, then the info URL, then the script text, and runs it.
package main

import (
	"crypto/rand"
	"encoding/hex"
	"encoding/json"
	"log"
	"net/http"
	"os"
	"path/filepath"
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

var packages = map[string]*Package{}

var scriptsDir = "scripts"

func genID() string {
	b := make([]byte, 8)
	rand.Read(b)
	return hex.EncodeToString(b)
}

func loadCatalog(path string) error {
	f, err := os.Open(path)
	if err != nil {
		return err
	}
	defer f.Close()

	var entries []catalogEntry
	if err := json.NewDecoder(f).Decode(&entries); err != nil {
		return err
	}

	for _, e := range entries {
		packages[e.Name] = &Package{
			Name:        e.Name,
			Description: e.Description,
			InstallID:   genID(),
			InfoURL:     "/api/info/" + e.Name,
			scriptURL:   "/scripts/" + e.Name + ".txt",
		}
	}
	return nil
}

func handleList(w http.ResponseWriter, r *http.Request) {
	list := make([]*Package, 0, len(packages))
	for _, p := range packages {
		list = append(list, p)
	}
	w.Header().Set("Content-Type", "application/json")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	json.NewEncoder(w).Encode(list)
}

func handleInfo(w http.ResponseWriter, r *http.Request) {
	name := r.URL.Path[len("/api/info/"):]
	p, ok := packages[name]
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
	// re-validate against the catalog so we never serve arbitrary files.
	base := name
	if ext := filepath.Ext(base); ext == ".txt" {
		base = base[:len(base)-len(ext)]
	}
	if _, ok := packages[base]; !ok {
		http.Error(w, "script not found", http.StatusNotFound)
		return
	}
	w.Header().Set("Content-Type", "text/plain")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	http.ServeFile(w, r, filepath.Join(scriptsDir, base+".txt"))
}

func main() {
	catalogPath := os.Getenv("DOCKERPATCH_CATALOG")
	if catalogPath == "" {
		catalogPath = "packages.json"
	}
	if err := loadCatalog(catalogPath); err != nil {
		log.Fatalf("failed to load catalog from %s: %v", catalogPath, err)
	}
	log.Printf("loaded %d packages from %s", len(packages), catalogPath)

	if v := os.Getenv("DOCKERPATCH_SCRIPTS_DIR"); v != "" {
		scriptsDir = v
	}

	port := os.Getenv("PORT")
	if port == "" {
		port = "8940"
	}

	http.HandleFunc("/api/list", handleList)
	http.HandleFunc("/api/info/", handleInfo)
	http.HandleFunc("/scripts/", handleScript)

	log.Printf("dockerpatch server listening on :%s", port)
	log.Fatal(http.ListenAndServe(":"+port, nil))
}
