package handlers

import (
	"database/sql"
	"golovina/db"
	"golovina/models"
	"golovina/utils"
	"net/http"

	"github.com/labstack/echo/v4"
)

type Session struct {
	Id       uint   `json:"id"`
	Name     string `json:"email"`
	Cart     int64  `json:"cart"`
	Wishlist int64  `json:"wishlist"`
}

func ShowSession(c echo.Context) error {
	db := db.DB()
	cookie, err := c.Cookie("_golovina_session")
	userId := 0

	if err == nil {
		userId = utils.Decrypt(cookie.Value)
	}

	var user models.User
	db.First(&user, userId)

	var cart sql.NullInt64
	db.Debug().Model(&models.Order{}).
		Joins("LEFT JOIN order_items ON order_items.order_id = orders.id").
		Where(&models.Order{UserID: user.ID}, "user_id").Select("sum(order_items.quantity)").
		Scan(&cart)

	var wishlist int64
	db.Debug().Model(&models.Wishlist{}).
		Joins("LEFT JOIN variants ON variants.id = wishlists.variant_id").
		Where(&models.Wishlist{UserID: user.ID}, "user_id").
		Where("variants.category_id IS NOT NULL").
		Where("variants.state = ?", 1).
		Count(&wishlist)

	return c.JSON(http.StatusOK, Session{Id: user.ID, Name: user.Name, Cart: cart.Int64, Wishlist: wishlist})
}
