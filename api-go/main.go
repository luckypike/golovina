package main

import (
	"fmt"
	"golovina/utils"
	"net/http"
	"net/url"

	"github.com/labstack/echo/v4"
)

func main() {
	e := echo.New()
	e.GET("/", func(c echo.Context) error {
		cookie, _ := c.Cookie("_golovina_session")

		encryptedCookie, _ := url.QueryUnescape(cookie.Value)
		userId := utils.Decrypt(encryptedCookie)
		fmt.Println(userId)

		return c.String(http.StatusOK, "Hello, World!")
	})
	e.Logger.Fatal(e.Start(":3000"))
}
