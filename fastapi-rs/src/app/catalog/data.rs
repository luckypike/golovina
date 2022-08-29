use sea_orm::prelude::Decimal;
use serde::{Deserialize, Serialize};

use crate::app::{
    categories::models::CategoryWithTranslation, themes::models::ThemeWithTranslation,
    variants::models::VariantWithTranslation,
};

#[derive(Serialize, Deserialize)]
pub struct CatalogData {
    pub entity: Option<CatalogEntityData>,
    pub variants: Vec<CatalogVariantData>,
}

#[derive(Serialize, Deserialize)]
pub struct CatalogVariantData {
    id: i64,
    title: String,
    state: i32,
    price: Option<Decimal>,
    price_last: Option<Decimal>,
}

impl From<VariantWithTranslation> for CatalogVariantData {
    fn from((variant, variant_translation): VariantWithTranslation) -> Self {
        let translation = variant_translation.unwrap();

        CatalogVariantData {
            id: variant.id,
            title: translation.title,
            state: variant.state,
            price: None,
            price_last: None,
        }
    }
}

#[derive(Serialize, Deserialize)]
pub struct CatalogEntityData {
    pub id: i64,
    pub kind: String,
    pub title: String,
}

impl From<CategoryWithTranslation> for CatalogEntityData {
    fn from((category, category_translation): CategoryWithTranslation) -> Self {
        let translation = category_translation.unwrap();

        CatalogEntityData {
            id: category.id,
            kind: "category".to_string(),
            title: translation.title,
        }
    }
}

impl From<ThemeWithTranslation> for CatalogEntityData {
    fn from((theme, theme_translation): ThemeWithTranslation) -> Self {
        let translation = theme_translation.unwrap();

        CatalogEntityData {
            id: theme.id,
            kind: "theme".to_string(),
            title: translation.title,
        }
    }
}

#[derive(Debug, Deserialize)]
#[allow(dead_code)]
pub struct ParamsData {
    // #[serde(default, deserialize_with = "empty_string_as_none")]
    pub slug: Option<String>,
}
