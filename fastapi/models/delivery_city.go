package models

type DeliveryCity struct {
	ID          uint   `gorm:"primaryKey" json:"id"`
	Title       string `json:"title"`
	Door        int    `json:"door"`
	DoorDays    string `json:"door_days"`
	Storage     int    `json:"storage"`
	StorageDays string `json:"storage_days"`
	Fast        bool   `json:"fast"`
}
