use sea_orm::{EntityTrait, DatabaseConnection, QueryOrder};

use super::data::DeliveryCityData;
use super::entities;

pub async fn index(pool: DatabaseConnection) -> Vec<DeliveryCityData> {
    let delivery_cities: Vec<entities::delivery_city::Model> = entities::delivery_city::Entity::find()
        .order_by_desc(entities::delivery_city::Column::Fast)
        .order_by_asc(entities::delivery_city::Column::Title)
        .all(&pool).await.unwrap();

    delivery_cities.into_iter().map(|x| x.into()).collect()
}
