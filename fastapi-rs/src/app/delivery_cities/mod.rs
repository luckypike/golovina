use axum::{Json, Extension};
use sea_orm::{EntityTrait, DatabaseConnection};
use self::data::DeliveryCityData;

mod entities;
mod data;
mod service;

pub async fn index(Extension(pool): Extension<DatabaseConnection>) -> Json<Vec<DeliveryCityData>> {
    let delivery_cities: Vec<entities::delivery_city::Model> = entities::delivery_city::Entity::find()
        .all(&pool).await.unwrap();

    Json(delivery_cities.into_iter().map(|x| x.into()).collect())
}
