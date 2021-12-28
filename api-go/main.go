package main

import (
	"fmt"
	"golovina/models"
	"golovina/utils"
	"net/http"
	"net/url"
	"os"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

var db *gorm.DB

func main() {
	dsn := fmt.Sprintf("host=%s user=%s password=%s dbname=%s port=%s", os.Getenv("DATABASE_HOST"), "postgres", "postgres", "golovina-dev", "5432")
	db, _ = gorm.Open(postgres.Open(dsn), &gorm.Config{})

	e := echo.New()
	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	e.GET("/", func(c echo.Context) error {
		cookie, _ := c.Cookie("_golovina_session")

		encryptedCookie, _ := url.QueryUnescape(cookie.Value)
		userId := utils.Decrypt(encryptedCookie)
		fmt.Println("userId", userId)

		var user models.User
		db.First(&user, userId)

		fmt.Println(user)

		return c.String(http.StatusOK, "Hello, World!")
	})
	e.Logger.Fatal(e.Start(":3000"))
}
