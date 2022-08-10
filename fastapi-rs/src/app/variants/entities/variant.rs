use sea_orm::entity::prelude::*;
use serde::Serialize;

#[derive(Clone, Debug, PartialEq, DeriveEntityModel, Serialize)]
#[sea_orm(table_name = "variants")]
pub struct Model {
    #[sea_orm(primary_key)]
    pub id: i64,
    pub state: i32,
    pub user_id: i64,
    pub category_id: i64,
}

#[derive(Copy, Clone, Debug, EnumIter, DeriveRelation)]
pub enum Relation {
    #[sea_orm(has_many = "super::order_item::Entity")]
    OrderItem,
    #[sea_orm(has_many = "super::wishlist::Entity")]
    Wishlist,
}

impl Related<super::order_item::Entity> for Entity {
    fn to() -> RelationDef {
        Relation::OrderItem.def()
    }
}

impl Related<super::wishlist::Entity> for Entity {
    fn to() -> RelationDef {
        Relation::Wishlist.def()
    }
}

impl ActiveModelBehavior for ActiveModel {}
