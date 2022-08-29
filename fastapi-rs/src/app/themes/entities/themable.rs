use sea_orm::entity::prelude::*;
use serde::Serialize;

#[derive(Clone, Debug, PartialEq, DeriveEntityModel, Serialize)]
#[sea_orm(table_name = "themables")]
pub struct Model {
    #[sea_orm(primary_key)]
    pub id: i64,
    pub variant_id: i64,
    pub theme_id: i64,
    pub weight: i32,
}

#[derive(Copy, Clone, Debug, EnumIter, DeriveRelation)]
pub enum Relation {
    #[sea_orm(
        belongs_to = "super::theme::Entity",
        from = "Column::ThemeId",
        to = "super::theme::Column::Id"
    )]
    Theme,
    #[sea_orm(
        belongs_to = "super::variant::Entity",
        from = "Column::VariantId",
        to = "super::variant::Column::Id"
    )]
    Variant,
}

impl Related<super::theme::Entity> for Entity {
    fn to() -> RelationDef {
        Relation::Theme.def()
    }
}

impl Related<super::variant::Entity> for Entity {
    fn to() -> RelationDef {
        Relation::Variant.def()
    }
}

impl ActiveModelBehavior for ActiveModel {}
