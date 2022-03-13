package models

type User struct {
	ID     uint `gorm:"primaryKey"`
	Email  string
	Phone  string
	Name   string
	Sname  string
	State  int
	Editor bool
}
