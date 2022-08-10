use sea_orm::entity::prelude::*;
use serde::Serialize;

#[derive(Clone, Debug, PartialEq, DeriveEntityModel, Serialize)]
#[sea_orm(table_name = "wishlists")]
pub struct Model {
    #[sea_orm(primary_key)]
    pub id: i64,
    pub variant_id: i64,
    pub user_id: i64,
}

#[derive(Copy, Clone, Debug, EnumIter, DeriveRelation)]
pub enum Relation {
    #[sea_orm(
        belongs_to = "super::variant::Entity",
        from = "Column::VariantId",
        to = "super::variant::Column::Id"
    )]
    Variant,
}

impl Related<super::variant::Entity> for Entity {
    fn to() -> RelationDef {
        Relation::Variant.def()
    }
}

impl ActiveModelBehavior for ActiveModel {}
