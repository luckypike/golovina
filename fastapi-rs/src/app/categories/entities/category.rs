use sea_orm::entity::prelude::*;
use serde::Serialize;
// use super::category_translation::Entity as CategoryTranslation

#[derive(Clone, Debug, PartialEq, DeriveEntityModel, Serialize)]
#[sea_orm(table_name = "categories")]
pub struct Model {
    #[sea_orm(primary_key)]
    pub id: i64,
    pub slug: String,
    pub state: i32,
    pub weight: i32,
    pub variants_and_kits_count: i32
}

#[derive(Copy, Clone, Debug, EnumIter, DeriveRelation)]
pub enum Relation {
    #[sea_orm(has_many = "super::category_translation::Entity")]
    CategoryTranslation,
}

impl Related<super::category_translation::Entity> for Entity {
    fn to() -> RelationDef {
        Relation::CategoryTranslation.def()
    }
}

impl ActiveModelBehavior for ActiveModel {}
