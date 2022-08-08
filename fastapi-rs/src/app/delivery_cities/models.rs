use diesel::Queryable;
use serde::Serialize;

#[derive(Queryable, Serialize)]
pub struct DeliveryCity {
    pub id: i64,
    pub title: String,
    pub door: i32,
    pub door_days: String,
    pub storage: Option<i32>,
    pub storage_days: Option<String>,
    pub fast: bool,
}
