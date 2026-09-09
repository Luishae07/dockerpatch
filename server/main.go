// dockerpatch server — serves the package catalog (/api/list) and per-package
// info endpoints. Each package's info endpoint returns a plain-text GitHub
// raw URL pointing at the actual install script; the "docker install"
// wrapper downloads and runs that script.
package main

import (
	"crypto/rand"
	"encoding/hex"
	"encoding/json"
	"log"
	"net/http"
	"os"
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
	scriptURL   string
}

const rawBase = "https://raw.githubusercontent.com/Luishae07/dockerpatch/main/"

var packages = map[string]*Package{}

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
			scriptURL:   rawBase + e.Script,
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

func main() {
	catalogPath := os.Getenv("DOCKERPATCH_CATALOG")
	if catalogPath == "" {
		catalogPath = "packages.json"
	}
	if err := loadCatalog(catalogPath); err != nil {
		log.Fatalf("failed to load catalog from %s: %v", catalogPath, err)
	}
	log.Printf("loaded %d packages from %s", len(packages), catalogPath)

	port := os.Getenv("PORT")
	if port == "" {
		port = "8940"
	}

	http.HandleFunc("/api/list", handleList)
	http.HandleFunc("/api/info/", handleInfo)

	log.Printf("dockerpatch server listening on :%s", port)
	log.Fatal(http.ListenAndServe(":"+port, nil))
}
