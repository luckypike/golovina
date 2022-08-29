use sea_orm::entity::prelude::*;
use serde::Serialize;

#[derive(Clone, Debug, PartialEq, DeriveEntityModel, Serialize)]
#[sea_orm(table_name = "variants")]
pub struct Model {
    #[sea_orm(primary_key)]
    pub id: i64,
    pub state: i32,
    pub category_id: Option<i64>,
    pub color_id: Option<i64>,
    pub price: Option<Decimal>,
    pub price_last: Option<Decimal>,
    pub weight: i32,
}

#[derive(Copy, Clone, Debug, EnumIter, DeriveRelation)]
pub enum Relation {
    #[sea_orm(has_many = "super::variant_translation::Entity")]
    Translation,
    #[sea_orm(has_many = "super::order_item::Entity")]
    OrderItem,
    #[sea_orm(has_many = "super::wishlist::Entity")]
    Wishlist,
    #[sea_orm(has_many = "super::themable::Entity")]
    Themable,
}

impl Related<super::variant_translation::Entity> for Entity {
    fn to() -> RelationDef {
        Relation::Translation.def()
    }
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

impl Related<super::themable::Entity> for Entity {
    fn to() -> RelationDef {
        Relation::Themable.def()
    }
}

impl ActiveModelBehavior for ActiveModel {}
