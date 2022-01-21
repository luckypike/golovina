package models

type User struct {
	ID    uint `gorm:"primaryKey"`
	Email string
	Name  string
	Sname string
}
