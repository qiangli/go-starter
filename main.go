package main

import (
	"fmt"
	"github.com/qiangli/go2/web"
	"github.com/qiangli/go2/web/gorilla"
	"github.com/gorilla/mux"
	"net/http"
)

const files string = "static/"

var router = mux.NewRouter()
var server = gorilla.NewGorillaServer(router)

func healthHandler(res http.ResponseWriter, req *http.Request) {
	type health struct {
		Status    string `json:"status"`
		Timestamp int64  `json:"timestamp"`
	}
	m := &health{Status: "up", Timestamp: web.CurrentTimestamp()}
	server.HandleJson(m, res, req)
}

func main() {
	//REST api
	router.HandleFunc("/api/health", healthHandler)

	//static pages
	fmt.Printf("Serving files from: %s \n", files)
	router.PathPrefix("/").Handler(http.StripPrefix("/", http.FileServer(http.Dir(files))))

	web.Run(server)
}