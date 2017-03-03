package main

import (
	"fmt"
	"github.com/geaviation/goboot/web"
	"github.com/geaviation/goboot/web/gorilla"
	"github.com/gorilla/mux"
	"net/http"
	"os"
)

const files string = "static/"

func main() {
	router := mux.NewRouter()
	gorilla := gorilla.NewGorillaServer(router)

	// Health REST service endpoint
	router.HandleFunc("/api/health", func(res http.ResponseWriter, req *http.Request) {
		type health struct {
			Status    string `json:"status"`
			Home      string `json:"home"`
			Name      string `json:"name"`
			Version   string `json:"version"`
			Build     string `json:"build"`
			Timestamp int64  `json:"timestamp"`
		}
		n := gorilla.Ctx.Env.GetStringEnv("VCAP_APPLICATION", "name")
		v := gorilla.Ctx.Env.GetStringEnv("VCAP_APPLICATION", "version")
		b := gorilla.Ctx.Env.GetStringEnv("build")

		m := &health{Status: "up", Name: n, Version: v, Build: b, Timestamp: web.CurrentTimestamp()}

		gorilla.HandleJson(m, res, req)
	})

	// Serve static files from static/ folder if found
	// or else show the following default page
	defaultPage := `<html><body><a href="/api/health">Health Service</a><br />Current Time: %v</body></html>`

	pwd, _ := os.Getwd()
	fmt.Printf("Working directory: %s\n", pwd)

	if _, err := os.Stat(files); err == nil {
		fmt.Printf("Serving files from: %s/%s \n", pwd, files)

		router.PathPrefix("/").Handler(http.StripPrefix("/", http.FileServer(http.Dir(files))))
	} else {

		fmt.Printf("Directory %s missing in %s\n", files, pwd)

		router.HandleFunc("/", func(res http.ResponseWriter, req *http.Request) {
			res.Header().Set("Content-Type", web.ContentType.HTML)
			res.WriteHeader(http.StatusOK)

			now := web.CurrentTimestamp()
			html := fmt.Sprintf(defaultPage, now)

			fmt.Fprintf(res, html)
		})
	}

	fmt.Print(gorilla)

	web.Run(gorilla)
}