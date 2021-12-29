package db

import (
	"fmt"
	"os"

	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

var db *gorm.DB
var err error

func Connect() {
	dsn := fmt.Sprintf("host=%s user=%s password=%s dbname=%s port=%s", os.Getenv("DATABASE_HOST"), "postgres", "postgres", "golovina-dev", "5432")
	db, err = gorm.Open(postgres.Open(dsn), &gorm.Config{})
}

func DB() *gorm.DB {
	return db
}
