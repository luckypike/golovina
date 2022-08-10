// use diesel::dsl::{sum, count};
// use diesel::prelude::*;

use crate::app::{Locale, User};
// use crate::app::users::users::User;
// use crate::app::db::Connection;
// use crate::schema::{ categories, category_translations, themes, theme_translations, orders, order_items, variants, wishlists };
use super::data::{ SessionData };

use sea_orm::DatabaseConnection;


pub fn show(user: User, _locale: &Locale, _pool: DatabaseConnection) -> SessionData {
    SessionData {
        user: user.into(),
        // categories: get_categories(&locale, &mut conn),
        // themes: get_themes(&locale, &mut conn),
        // cart: get_cart(&user, &mut conn).unwrap_or(0),
        // wishlist: get_wishlist(&user, &mut conn)
    }
}

// fn get_categories(locale: &Locale, conn: &mut Connection) -> Vec<SessionCategoryData> {
//     categories::table.inner_join(
//         category_translations::table
//             .on(
//                 category_translations::category_id.eq(categories::id)
//                 .and(category_translations::locale.eq(match locale {
//                     Locale::EN => "en",
//                     Locale::RU => "ru",
//                 }))
//             )
//     )
//         .select((
//             categories::id, category_translations::title, category_translations::desc,
//             categories::slug, categories::weight,
//         ))
//         .order(categories::weight.asc())
//         .filter(
//             categories::state.eq(1)
//             .and(categories::variants_and_kits_count.gt(0))
//         )
//         .load::<SessionCategoryData>(conn)
//         .unwrap()
// }

// fn get_themes(locale: &Locale, conn: &mut Connection) -> Vec<SessionThemeData> {
//     themes::table.inner_join(
//         theme_translations::table
//             .on(
//                 theme_translations::theme_id.eq(themes::id)
//                 .and(theme_translations::locale.eq(match locale {
//                     Locale::EN => "en",
//                     Locale::RU => "ru",
//                 }))
//             )
//     )
//         .select((
//             themes::id, theme_translations::title, theme_translations::desc,
//             themes::slug, themes::weight,
//         ))
//         .order(themes::weight.asc())
//         .filter(themes::state.eq(1))
//         .load::<SessionThemeData>(conn)
//         .unwrap()
// }

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
