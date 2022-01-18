package models

type Category struct {
	ID                   uint `gorm:"primaryKey" json:"id"`
	State                int  `json:"state"`
	Weight               int  `json:"weight"`
	CategoryTranslations []CategoryTranslation
}
