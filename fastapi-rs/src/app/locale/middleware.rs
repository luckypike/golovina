// use tide::{Middleware, Request, Next};

// use crate::app::AppState;

// #[derive(Debug)]
// pub enum Locale {
//     RU,
//     EN
// }

// pub struct LocaleMiddleware {}

// impl LocaleMiddleware {
//     pub fn new() -> Self {
//         Self {}
//     }
// }

// #[tide::utils::async_trait]
// impl Middleware<AppState> for LocaleMiddleware {
//     async fn handle(&self, mut req: Request<AppState>, next: Next<'_, AppState>) -> tide::Result {
//         let locale = match req.header("X-Locale") {
//             Some(v) => match v.last().as_str() {
//                 "en" => Locale::EN,
//                 _ => Locale::RU
//             },
//             None => Locale::RU,
//         };
//         req.set_ext(locale);
//         Ok(next.run(req).await)
//     }
// }
