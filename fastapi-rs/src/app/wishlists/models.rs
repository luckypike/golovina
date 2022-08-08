use diesel::Queryable;
use serde::Serialize;

#[derive(Queryable, Debug, Clone, Serialize)]
pub struct Wishlist {
    pub id: i64,
    pub variant_id: i64,
    pub user_id: i64,
}

