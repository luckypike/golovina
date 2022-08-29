use axum::{extract::Query, http::StatusCode, Extension, Json};
use sea_orm::DatabaseConnection;

use self::data::{CatalogData, ParamsData};
use super::{Locale, User};

mod data;
mod entities;
mod service;

pub async fn index(
    user: User,
    locale: Locale,
    Query(params): Query<ParamsData>,
    Extension(pool): Extension<DatabaseConnection>,
) -> Result<Json<CatalogData>, StatusCode> {
    if let Some(variants) = service::index(user, locale, params.slug, pool).await {
        Ok(Json(variants))
    } else {
        return Err(StatusCode::NOT_FOUND);
    }
}
