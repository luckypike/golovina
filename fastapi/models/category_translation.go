package models

type CategoryTranslation struct {
	ID         uint `gorm:"primaryKey"`
	Title      string
	Locale     string
	CategoryID uint
	Category   Category
}
