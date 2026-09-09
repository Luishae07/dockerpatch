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

type Package struct {
	Name      string `json:"name"`
	InstallID string `json:"install_id"`
	InfoURL   string `json:"info_url"` // relative path on this server; GET returns plain-text script URL
	scriptURL string // the actual GitHub raw URL, not exposed directly in /api/list
}

var packages = map[string]*Package{}

func genID() string {
	b := make([]byte, 8)
	rand.Read(b)
	return hex.EncodeToString(b)
}

func registerPackage(name, scriptURL string) {
	id := genID()
	packages[name] = &Package{
		Name:      name,
		InstallID: id,
		InfoURL:   "/api/info/" + name,
		scriptURL: scriptURL,
	}
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
	// Seed catalog — real entries point at raw.githubusercontent.com scripts.
	registerPackage("webui", "https://raw.githubusercontent.com/Luishae07/dockerpatch/main/packages/webui.sh")

	port := os.Getenv("PORT")
	if port == "" {
		port = "8940"
	}

	http.HandleFunc("/api/list", handleList)
	http.HandleFunc("/api/info/", handleInfo)

	log.Printf("dockerpatch server listening on :%s", port)
	log.Fatal(http.ListenAndServe(":"+port, nil))
}
