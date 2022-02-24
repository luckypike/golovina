package main

import (
	"golovina/db"
	"golovina/handlers"
	"os"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	"github.com/newrelic/go-agent/v3/integrations/nrecho-v4"
	"github.com/newrelic/go-agent/v3/newrelic"
)

func main() {
	app, _ := newrelic.NewApplication(
		newrelic.ConfigAppName(os.Getenv("NEW_RELIC_APP_NAME")),
		newrelic.ConfigLicense(os.Getenv("NEW_RELIC_API_KEY")),
	)

	e := echo.New()
	e.Use(middleware.Logger())
	e.Use(middleware.Recover())
	e.Use(nrecho.Middleware(app))

	db.Connect()

	e.GET("/api/session", handlers.ShowSession)
	e.GET("/api/delivery_cities", handlers.IndeDeliveryCities)

	e.Logger.Fatal(e.Start(":3000"))
}
