use sea_orm::DatabaseConnection;
use axum::{Json, Extension};
use self::data::SessionData;
use super::{Locale, User};

mod service;
mod data;
mod entities;

pub async fn show(
    user: User,
    locale: Locale,
    Extension(pool): Extension<DatabaseConnection>
) -> Json<SessionData> {
    Json(service::show(user, locale, pool).await)
}
