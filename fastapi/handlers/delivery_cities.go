package handlers

import (
	"golovina/db"
	"golovina/models"
	"net/http"

	"github.com/labstack/echo/v4"
)

func IndeDeliveryCities(c echo.Context) error {
	db := db.DB()

	var delivery_cities []models.DeliveryCity
	db.Debug().Order("fast DESC").Order("title ASC").Find(&delivery_cities)

	return c.JSON(
		http.StatusOK,
		delivery_cities,
	)
}
