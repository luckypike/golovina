package handlers

import (
	"database/sql"
	"golovina/db"
	"golovina/models"
	"golovina/utils"
	"net/http"

	"github.com/labstack/echo/v4"
)

type session struct {
	Id         uint       `json:"id"`
	Name       string     `json:"email"`
	Cart       int64      `json:"cart"`
	Wishlist   int64      `json:"wishlist"`
	Categories []nav_item `json:"categories"`
	Themes     []nav_item `json:"themes"`
}

type nav_item struct {
	Id     uint   `json:"id"`
	Title  string `json:"title"`
	Slug   string `json:"slug"`
	Weight int    `json:"weight"`
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

	var categories []nav_item
	db.Debug().
		Table("category_translations ct").
		Select("c.id, ct.title, c.slug, c.weight").
		Joins("INNER JOIN categories c ON ct.category_id = c.id").
		Where("ct.locale = ? AND c.state = ?", "ru", 1).
		Order("c.weight asc").
		Find(&categories)

	var themes []nav_item
	db.Debug().
		Table("theme_translations tt").
		Select("t.id, tt.title, t.weight").
		Joins("INNER JOIN themes t ON tt.theme_id = t.id").
		Where("tt.locale = ? AND t.state = ?", "ru", 1).
		Order("t.weight asc").
		Find(&themes)

	return c.JSON(
		http.StatusOK,
		session{
			Id:         user.ID,
			Name:       user.Name,
			Cart:       cart.Int64,
			Wishlist:   wishlist,
			Categories: categories,
			Themes:     themes,
		},
	)
}
