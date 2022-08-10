use crate::app::{ Locale, User };
use super::entities;
use super::data::{ SessionData, SessionCategoryData, SessionThemeData };

use sea_orm::{EntityTrait, DatabaseConnection, QueryFilter, ColumnTrait, QueryOrder};

pub async fn show(user: User, locale: Locale, pool: DatabaseConnection) -> SessionData {

    SessionData {
        user: user.into(),
        categories: get_categories(&locale, &pool).await,
        themes: get_themes(&locale, &pool).await,
        // cart: get_cart(&user, &mut conn).unwrap_or(0),
        // wishlist: get_wishlist(&user, &mut conn)
    }
}

async fn get_categories(locale: &Locale, pool: &DatabaseConnection) -> Vec<SessionCategoryData> {
    let categories: Vec<(entities::category::Model, Vec<entities::category_translation::Model>)> = entities::category::Entity::find()
        .find_with_related(entities::category_translation::Entity)
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
    let categories: Vec<(entities::theme::Model, Vec<entities::theme_translation::Model>)> = entities::theme::Entity::find()
        .find_with_related(entities::theme_translation::Entity)
        .filter(entities::theme_translation::Column::Locale.eq(match locale {
            Locale::EN => "en",
            Locale::RU => "ru",
        }))
        .filter(entities::theme::Column::State.eq(1))
        .order_by_asc(entities::theme::Column::Weight)
        .all(pool).await.unwrap();

    categories.into_iter().map(|x| x.into()).collect()
}

// fn get_cart(user: &User, conn: &mut Connection) -> Option<i64> {
//     order_items::table
//         .inner_join(
//             orders::table
//                 .on(
//                     order_items::order_id.eq(orders::id)
//                     .and(orders::state.eq(0))
//                     .and(orders::user_id.eq(user.id))
//                 )
//         )
//         .inner_join(
//             variants::table
//                 .on(
//                     order_items::variant_id.eq(variants::id)
//                     .and(orders::state.eq(0))
//                 )
//         )
//         .select(sum(order_items::quantity))
//         .first::<Option<i64>>(conn)
//         .unwrap()
// }

// fn get_wishlist(user: &User, conn: &mut Connection) -> i64 {
//     wishlists::table
//         .inner_join(
//             variants::table
//                 .on(
//                     wishlists::variant_id.eq(variants::id)
//                     .and(variants::state.eq(1))
//                     .and(variants::category_id.is_not_null())
//                 )
//         )
//         .select(count(wishlists::id))
//         .filter(wishlists::user_id.eq(user.id))
//         .first::<i64>(conn)
//         .unwrap()
// }
