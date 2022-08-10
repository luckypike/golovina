use serde::{Serialize, Deserialize};

use crate::app::User;
use super::entities;

#[derive(Serialize, Deserialize)]
pub struct SessionCategoryData {
    pub id: i64,
    pub title: String,
    pub slug: String,
    pub weight: i32
}

impl From<(entities::category::Model, Option<entities::category_translation::Model>)> for SessionCategoryData {
    fn from(i: (entities::category::Model, Option<entities::category_translation::Model>)) -> Self {
        let translation = i.1.unwrap_or(
            entities::category_translation::Model {
                id: 0,
                category_id: 0,
                locale: "".to_string(),
                title: "".to_string(),
                desc: None
            }
        );

        SessionCategoryData {
            id: i.0.id,
            slug: i.0.slug,
            weight: i.0.weight,
            title: translation.title,
        }
    }
}

#[derive(Serialize)]
pub struct SessionThemeData {
    pub id: i64,
    pub title: String,
    pub slug: String,
    pub weight: i32
}

impl From<(entities::theme::Model, Option<entities::theme_translation::Model>)> for SessionThemeData {
    fn from(i: (entities::theme::Model, Option<entities::theme_translation::Model>)) -> Self {
        let translation = i.1.unwrap_or(
            entities::theme_translation::Model {
                id: 0,
                theme_id: 0,
                locale: "".to_string(),
                title: "".to_string(),
                desc: None
            }
        );

        SessionThemeData {
            id: i.0.id,
            slug: i.0.slug,
            weight: i.0.weight,
            title: translation.title,
        }
    }
}

#[derive(Serialize, Deserialize)]
pub struct SessionUserData {
    pub id: i64,
    pub email: String,
    pub name: Option<String>,
    pub sname: Option<String>,
    pub phone: Option<String>,
    pub state: i32,
    pub editor: bool,
}

#[derive(Serialize)]
pub struct SessionData {
    pub user: SessionUserData,
    pub categories: Vec<SessionCategoryData>,
    pub themes: Vec<SessionThemeData>,
    pub cart: i64,
    pub wishlist: i64,
}

impl From<User> for SessionUserData {
    fn from(user: User) -> Self {
        let v = serde_json::to_value(&user).unwrap();
        serde_json::from_value(v).unwrap()
    }
}
