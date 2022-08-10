use serde::{Serialize, Deserialize};
use super::entities;

#[derive(Serialize, Deserialize)]
pub struct DeliveryCityData {
    pub id: i64,
    pub title: String,
    pub door: i32,
    pub door_days: String,
    pub storage: Option<i32>,
    pub storage_days: Option<String>,
    pub fast: bool,
}

impl From<entities::delivery_city::Model> for DeliveryCityData {
    fn from(model: entities::delivery_city::Model) -> Self {
        let v = serde_json::to_value(&model).unwrap();
        serde_json::from_value(v).unwrap()
    }
}
