use axum::{ Json, Extension };
use sea_orm::DatabaseConnection;
use self::data::DeliveryCityData;

mod entities;
mod data;
mod service;

#[tracing::instrument]
pub async fn index(Extension(pool): Extension<DatabaseConnection>) -> Json<Vec<DeliveryCityData>> {
    Json(service::index(pool).await)
}
