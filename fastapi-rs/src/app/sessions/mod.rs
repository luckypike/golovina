use axum::Json;
use self::data::SessionData;
use super::{users::models::User, DatabaseConnection, Locale};

mod service;
mod data;

pub async fn show(
    user: User,
    locale: Locale,
    DatabaseConnection(conn): DatabaseConnection
) -> Json<SessionData> {
    Json(service::show(&user, locale, conn))
}
