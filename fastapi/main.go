package main

import (
	"golovina/db"
	"golovina/handlers"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

func main() {
	e := echo.New()
	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	db.Connect()

	e.GET("/api/session", handlers.ShowSession)

	e.Logger.Fatal(e.Start(":3000"))
}
