use serde::{Serialize, Deserialize};

use crate::app::User;

#[derive(Serialize)]
pub struct SessionCategoryData {
    pub id: i64,
    pub title: String,
    pub desc: Option<String>,
    pub slug: String,
    pub weight: i32
}

#[derive(Serialize)]
pub struct SessionThemeData {
    pub id: i64,
    pub title: String,
    pub desc: Option<String>,
    pub slug: String,
    pub weight: i32
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
    // pub categories: Vec<SessionCategoryData>,
    // pub themes: Vec<SessionThemeData>,
    // pub cart: i64,
    // pub wishlist: i64,
}

impl From<User> for SessionUserData {
    fn from(user: User) -> Self {
        let v = serde_json::to_value(&user).unwrap();
        serde_json::from_value(v).unwrap()
    }
}
