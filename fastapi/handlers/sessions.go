package handlers

import (
	"database/sql"
	"golovina/db"
	"golovina/models"
	"golovina/utils"
	"net/http"
	"regexp"

	"github.com/labstack/echo/v4"
)

type session struct {
	User       user       `json:"user"`
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

type user struct {
	Id     uint   `json:"id"`
	State  int    `json:"state"`
	Editor bool   `json:"editor"`
	Phone  string `json:"phone"`
	Email  string `json:"email"`
	Name   string `json:"name"`
	Sname  string `json:"sname"`
}

func ShowSession(c echo.Context) error {
	db := db.DB()
	cookie, err := c.Cookie("_golovina_session")
	userId := 0

	var locale string = c.Request().Header.Get("X-Locale")
	if locale != "ru" && locale != "en" {
		locale = "ru"
	}

	if err == nil {
		userId = utils.Decrypt(cookie.Value)
	}

	var user_data models.User
	db.First(&user_data, userId)

	is_guest_email, _ := regexp.MatchString("guest_(.+)@golovinamari.com", user_data.Email)
	is_private_relay_email, _ := regexp.MatchString("(.+)@privaterelay.appleid.com", user_data.Email)
	if is_guest_email || is_private_relay_email {
		user_data.Email = ""
	}

	var cart sql.NullInt64
	db.Debug().
		Table("order_items oi").
		Joins("INNER JOIN orders o ON oi.order_id = o.id AND o.state = ? AND o.user_id = ?", 0, user_data.ID).
		Joins("INNER JOIN variants v ON v.id = oi.variant_id AND v.state = ?", 1).
		Select("sum(oi.quantity)").Scan(&cart)

	var wishlist int64
	db.Debug().Model(&models.Wishlist{}).
		Joins("LEFT JOIN variants ON variants.id = wishlists.variant_id").
		Where(&models.Wishlist{UserID: user_data.ID}, "user_id").
		Where("variants.category_id IS NOT NULL").
		Where("variants.state = ?", 1).
		Count(&wishlist)

	var categories []nav_item
	db.Debug().
		Table("category_translations ct").
		Select("c.id, ct.title, c.slug, c.weight").
		Joins("INNER JOIN categories c ON ct.category_id = c.id").
		Where("ct.locale = ? AND c.state = ? AND variants_and_kits_count > ?", locale, 1, 0).
		Order("c.weight asc").
		Find(&categories)

	var themes []nav_item
	db.Debug().
		Table("theme_translations tt").
		Select("t.id, tt.title, t.weight, t.slug").
		Joins("INNER JOIN themes t ON tt.theme_id = t.id").
		Where("tt.locale = ? AND t.state = ?", locale, 1).
		Order("t.weight asc").
		Find(&themes)

	return c.JSON(
		http.StatusOK,
		session{
			User: user{
				Id:     user_data.ID,
				State:  user_data.State,
				Editor: user_data.Editor,
				Name:   user_data.Name,
				Sname:  user_data.Sname,
				Email:  user_data.Email,
				Phone:  user_data.Phone,
			},
			Cart:       cart.Int64,
			Wishlist:   wishlist,
			Categories: categories,
			Themes:     themes,
		},
	)
}
