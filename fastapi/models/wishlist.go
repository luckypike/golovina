package models

type Wishlist struct {
	ID     uint `gorm:"primaryKey"`
	UserID uint
	User   User
}
