use axum::Json;
use models::DeliveryCity;
use super::DatabaseConnection;

pub mod models;
mod service;

pub async fn index(DatabaseConnection(conn): DatabaseConnection) -> Json<Vec<DeliveryCity>> {
    Json(service::index(conn))
}
