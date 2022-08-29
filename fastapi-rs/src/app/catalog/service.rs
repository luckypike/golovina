use super::data::CatalogData;
use super::entities;
use crate::app::categories::models::CategoryWithTranslation;
use crate::app::themes::models::ThemeWithTranslation;
use crate::app::variants::models::VariantWithTranslation;
use crate::app::{Locale, User};

use sea_orm::{ColumnTrait, DatabaseConnection, EntityTrait, QueryFilter, QueryOrder};

pub async fn index(
    _user: User,
    locale: Locale,
    slug: Option<String>,
    pool: DatabaseConnection,
) -> Option<CatalogData> {
    if let Some(data) = index_find_variants(&slug, &locale, &pool).await {
        Some(data)
    } else {
        None
    }
}

async fn index_find_variants(
    slug: &Option<String>,
    locale: &Locale,
    pool: &DatabaseConnection,
) -> Option<CatalogData> {
    match slug {
        Some(slug) => {
            if let Some((entity, variants)) =
                index_find_variants_by_category(slug, locale, pool).await
            {
                Some(CatalogData {
                    entity: Some(entity.into()),
                    variants: variants.into_iter().map(|x| x.into()).collect(),
                })
            } else if let Some((entity, variants)) =
                index_find_variants_by_theme(slug, locale, pool).await
            {
                Some(CatalogData {
                    entity: Some(entity.into()),
                    variants: variants.into_iter().map(|x| x.into()).collect(),
                })
            } else {
                None
            }
        }
        None => Some(CatalogData {
            entity: None,
            variants: index_find_variants_all(locale, pool)
                .await
                .into_iter()
                .map(|x| x.into())
                .collect(),
        }),
    }
}

async fn index_find_variants_by_category(
    slug: &String,
    locale: &Locale,
    pool: &DatabaseConnection,
) -> Option<(CategoryWithTranslation, Vec<VariantWithTranslation>)> {
    if let Some((category, category_translation)) = entities::category::Entity::find()
        .find_also_related(entities::category_translation::Entity)
        .filter(
            entities::category_translation::Column::Locale.eq(match locale {
                Locale::EN => "en",
                Locale::RU => "ru",
            }),
        )
        .filter(entities::category::Column::Slug.eq(slug.clone()))
        .one(pool)
        .await
        .unwrap()
    {
        dbg!(&category);
        let variants = entities::variant::Entity::find()
            .find_also_related(entities::variant_translation::Entity)
            .filter(
                entities::variant_translation::Column::Locale.eq(match locale {
                    Locale::EN => "en",
                    Locale::RU => "ru",
                }),
            )
            .filter(entities::variant::Column::CategoryId.eq(category.id))
            .filter(entities::variant::Column::State.eq(1))
            .order_by_desc(entities::variant::Column::Weight)
            .all(pool)
            .await
            .unwrap();

        Some(((category, category_translation), variants))
    } else {
        None
    }
}

async fn index_find_variants_by_theme(
    slug: &String,
    locale: &Locale,
    pool: &DatabaseConnection,
) -> Option<(ThemeWithTranslation, Vec<VariantWithTranslation>)> {
    if let Some((theme, theme_translation)) = entities::theme::Entity::find()
        .find_also_related(entities::theme_translation::Entity)
        .filter(
            entities::theme_translation::Column::Locale.eq(match locale {
                Locale::EN => "en",
                Locale::RU => "ru",
            }),
        )
        .filter(entities::theme::Column::Slug.eq(slug.clone()))
        .one(pool)
        .await
        .unwrap()
    {
        dbg!(&theme);
        let variants = entities::variant::Entity::find()
            .inner_join(entities::themable::Entity)
            .find_also_related(entities::variant_translation::Entity)
            .filter(
                entities::variant_translation::Column::Locale.eq(match locale {
                    Locale::EN => "en",
                    Locale::RU => "ru",
                }),
            )
            .filter(entities::variant::Column::State.eq(1))
            .filter(entities::themable::Column::ThemeId.eq(theme.id))
            .order_by_desc(entities::variant::Column::Weight)
            .all(pool)
            .await
            .unwrap();

        Some(((theme, theme_translation), variants))
    } else {
        None
    }
}

async fn index_find_variants_all(
    locale: &Locale,
    pool: &DatabaseConnection,
) -> Vec<VariantWithTranslation> {
    let variants = entities::variant::Entity::find()
        .find_also_related(entities::variant_translation::Entity)
        .filter(
            entities::variant_translation::Column::Locale.eq(match locale {
                Locale::EN => "en",
                Locale::RU => "ru",
            }),
        )
        .filter(entities::variant::Column::State.eq(1))
        .order_by_desc(entities::variant::Column::Weight)
        .all(pool)
        .await
        .unwrap();

    variants
}
