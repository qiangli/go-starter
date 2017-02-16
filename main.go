package main

import (
	"fmt"
	"github.com/geaviation/goboot/web"
	"github.com/geaviation/goboot/web/gorilla"
	"github.com/geaviation/goboot/web/jsonrest"
	"github.com/ant0ine/go-json-rest/rest"
	"net/http"
	"github.com/geaviation/goboot/web/restful"
)

func main() {
	//comment out/uncomment web.Run to run the server you wish
	gorilla := gorilla.NewGorillaServer()
	fmt.Print(gorilla)
	//web.Run(gorilla)

	//

	router, _ := rest.MakeRouter(
		rest.Get("/", jsonrest.HandlerAdapter(func(res http.ResponseWriter, req *http.Request) {
			type Limits struct {
				Disk int `json:"disk"`
				Mem  int `json:"mem"`
			}
			m := &Limits{Disk: 1234, Mem: 1024}
			web.Handle(m, res, req)
		})),
	)
	fmt.Print(router)
	//jsonrest := jsonrest.NewJsonRestServer()
	jsonrest := jsonrest.NewJsonRestServer(router)
	fmt.Print(jsonrest)
	//web.Run(jsonrest)

	restful := restful.NewRestfulServer()
	fmt.Print(restful)
	//web.Run(restful)

	web.Run()
}