use sea_orm::entity::prelude::*;
use serde::Serialize;

#[derive(Clone, Debug, PartialEq, DeriveEntityModel, Serialize)]
#[sea_orm(table_name = "themes")]
pub struct Model {
    #[sea_orm(primary_key)]
    pub id: i64,
    pub slug: String,
    pub state: i32,
    pub weight: i32,
}

#[derive(Copy, Clone, Debug, EnumIter, DeriveRelation)]
pub enum Relation {
    #[sea_orm(has_many = "super::theme_translation::Entity")]
    Translation,
}

impl Related<super::theme_translation::Entity> for Entity {
    fn to() -> RelationDef {
        Relation::Translation.def()
    }
}

impl ActiveModelBehavior for ActiveModel {}
