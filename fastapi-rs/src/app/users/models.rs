use diesel::Queryable;
use serde::Serialize;

#[derive(Queryable, Debug, Clone, Serialize)]
pub struct User {
    pub id: i64,
    pub email: String,
    pub name: Option<String>,
    pub sname: Option<String>,
    pub phone: Option<String>,
    pub state: i32,
    pub editor: bool,
}
