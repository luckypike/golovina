// use diesel::prelude::*;
// // use diesel::{QueryDsl, RunQueryDsl};

// use super::models::DeliveryCity;
// // use crate::app::DatabaseConnection;
// use crate::app::db::Connection;
// use crate::schema::delivery_cities::dsl::*;

// pub fn index(mut conn: Connection) -> Vec<DeliveryCity> {
//     delivery_cities
//         .order((fast.desc(), title.asc()))
//         .load::<DeliveryCity>(&mut conn)
//         .unwrap()
// }
