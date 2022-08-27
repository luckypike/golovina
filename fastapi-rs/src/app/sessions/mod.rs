use self::data::SessionData;
use super::{Locale, User};
use axum::{Extension, Json};
use sea_orm::DatabaseConnection;

mod data;
mod entities;
mod service;

pub async fn show(
    user: User,
    locale: Locale,
    Extension(pool): Extension<DatabaseConnection>,
) -> Json<SessionData> {
    Json(service::show(user, locale, pool).await)
}
