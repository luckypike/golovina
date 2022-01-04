package models

type Order struct {
	ID         uint `gorm:"primaryKey"`
	Email      string
	Name       string
	Sname      string
	State      int
	UserID     uint
	User       User
	OrderItems []OrderItem
}
