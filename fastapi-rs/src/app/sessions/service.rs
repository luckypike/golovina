use crate::app::{ Locale, User };
use super::entities;
use super::data::{ SessionData, SessionCategoryData, SessionThemeData };

use sea_orm::{EntityTrait, DatabaseConnection, QueryFilter, ColumnTrait, QueryOrder, QuerySelect, FromQueryResult};

pub async fn show(user: User, locale: Locale, pool: DatabaseConnection) -> SessionData {

    SessionData {
        user: user.clone().into(),
        categories: get_categories(&locale, &pool).await,
        themes: get_themes(&locale, &pool).await,
        cart: get_cart(&user, &pool).await,
        wishlist: get_wishlist(&user, &pool).await
    }
}

async fn get_categories(locale: &Locale, pool: &DatabaseConnection) -> Vec<SessionCategoryData> {
    let categories: Vec<(entities::category::Model, Option<entities::category_translation::Model>)> = entities::category::Entity::find()
        .find_also_related(entities::category_translation::Entity)
        .filter(entities::category_translation::Column::Locale.eq(match locale {
            Locale::EN => "en",
            Locale::RU => "ru",
        }))
        .filter(entities::category::Column::State.eq(1))
        .filter(entities::category::Column::VariantsAndKitsCount.gt(0))
        .order_by_asc(entities::category::Column::Weight)
        .all(pool).await.unwrap();

    categories.into_iter().map(|x| x.into()).collect()
}

async fn get_themes(locale: &Locale, pool: &DatabaseConnection) -> Vec<SessionThemeData> {
    let categories: Vec<(entities::theme::Model, Option<entities::theme_translation::Model>)> = entities::theme::Entity::find()
        .find_also_related(entities::theme_translation::Entity)
        .filter(entities::theme_translation::Column::Locale.eq(match locale {
            Locale::EN => "en",
            Locale::RU => "ru",
        }))
        .filter(entities::theme::Column::State.eq(1))
        .order_by_asc(entities::theme::Column::Weight)
        .all(pool).await.unwrap();

    categories.into_iter().map(|x| x.into()).collect()
}

async fn get_cart(user: &User, pool: &DatabaseConnection) -> i64 {
    #[derive(FromQueryResult)]
    struct CartResult {
        sum: i64
    }

    let query = entities::order_item::Entity::find()
        .select_only()
        .column_as(entities::order_item::Column::Quantity.sum(), "sum")
        .inner_join(entities::order::Entity)
        .inner_join(entities::variant::Entity)
        .filter(entities::order::Column::UserId.eq(user.id))
        .filter(entities::order::Column::State.eq(0))
        .filter(entities::variant::Column::State.eq(1));

    query.into_model::<CartResult>().one(pool).await.unwrap_or(Some(CartResult { sum: 0 })).unwrap().sum
}

async fn get_wishlist(user: &User, pool: &DatabaseConnection) -> i64 {
    #[derive(FromQueryResult)]
    struct WishlistResult {
        count: i64
    }

    let query = entities::wishlist::Entity::find()
        .select_only()
        .column_as(entities::wishlist::Column::Id.count(), "count")
        .inner_join(entities::variant::Entity)
        .filter(entities::wishlist::Column::UserId.eq(user.id))
        .filter(entities::variant::Column::State.eq(1))
        .filter(entities::variant::Column::CategoryId.is_not_null());

    query.into_model::<WishlistResult>().one(pool).await.unwrap_or(Some(WishlistResult { count: 0 })).unwrap().count
}
