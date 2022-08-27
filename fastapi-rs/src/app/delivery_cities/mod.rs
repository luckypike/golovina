use self::data::DeliveryCityData;
use axum::{Extension, Json};
use sea_orm::DatabaseConnection;

mod data;
mod entities;
mod service;

pub async fn index(Extension(pool): Extension<DatabaseConnection>) -> Json<Vec<DeliveryCityData>> {
    Json(service::index(pool).await)
}
