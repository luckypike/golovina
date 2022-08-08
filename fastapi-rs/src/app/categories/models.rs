use diesel::Queryable;
use serde::Serialize;

use crate::schema::*;

#[derive(Queryable, Serialize, Identifiable)]
#[diesel(table_name = categories)]
pub struct Category {
    pub id: i64,
    pub slug: String,
    pub state: i32,
    pub weight: i32,
    pub variants_and_kits_count: i32
}

#[derive(Queryable, Serialize, Identifiable)]
#[diesel(belongs_to(Category))]
#[diesel(table_name = category_translations)]
pub struct CategoryTranslation {
    pub id: i64,
    pub category_id: i64,
    pub locale: String,
    pub title: String,
    pub desc: Option<String>
}
