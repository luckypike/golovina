package models

type OrderItem struct {
	ID      uint `gorm:"primaryKey"`
	OrderID uint
	Order   Order
}
