use serde::Serialize;
use diesel::Queryable;
use crate::app::users::models::User;

#[derive(Queryable, Serialize)]
pub struct SessionCategoryData {
    pub id: i64,
    pub title: String,
    pub desc: Option<String>,
    pub slug: String,
    pub weight: i32
}

#[derive(Queryable, Serialize)]
pub struct SessionThemeData {
    pub id: i64,
    pub title: String,
    pub desc: Option<String>,
    pub slug: String,
    pub weight: i32
}

#[derive(Serialize)]
pub struct SessionData {
    pub user: User,
    pub categories: Vec<SessionCategoryData>,
    pub themes: Vec<SessionThemeData>,
    pub cart: i64,
    pub wishlist: i64,
}

