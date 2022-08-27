mod db;
mod s3;

mod categories;
mod delivery_cities;
mod orders;
mod sessions;
mod themes;
mod uploads;
mod users;
mod variants;
mod wishlists;

use axum::{
    async_trait,
    extract::{Extension, FromRequest, RequestParts},
    response::Response,
    routing::get,
    routing::post,
    Router,
};
use jsonwebtoken::{decode, Algorithm, DecodingKey, Validation};
use regex::Regex;
use sea_orm::prelude::*;
use sentry_tower::{NewSentryLayer, SentryHttpLayer};
use serde::{Deserialize, Serialize};
use std::{env, net::SocketAddr, str::FromStr};
use tower_cookies::{Cookie, CookieManagerLayer, Cookies};
use users::entities;

const JWT_COOKIE_NAME: &str = "_golovina_jwt";

pub async fn run() {
    let pool = db::create_pool(&env::var("DATABASE_URL").unwrap()).await;
    let s3_client = s3::create_s3_client(&env::var("AWS_ENDPOINT").unwrap()).await;

    let app = Router::new()
        .nest(
            "/api",
            Router::new()
                .route("/status", get(|| async {}))
                .route("/delivery-cities", get(delivery_cities::index))
                .route("/session", get(sessions::show))
                .route("/upload/:preset", post(uploads::create)),
        )
        .layer(CookieManagerLayer::new())
        .layer(Extension(pool))
        .layer(Extension(s3_client))
        .layer(SentryHttpLayer::with_transaction())
        .layer(NewSentryLayer::new_from_top());

    let addr = SocketAddr::from_str(&env::var("APP_ADDR").unwrap()).unwrap();

    axum::Server::bind(&addr)
        .serve(app.into_make_service())
        .await
        .unwrap();
}

#[derive(Debug)]
pub enum Locale {
    RU,
    EN,
}

#[async_trait]
impl<B> FromRequest<B> for Locale
where
    B: Send,
{
    type Rejection = Response;

    async fn from_request(req: &mut RequestParts<B>) -> Result<Self, Self::Rejection> {
        // let qq = req.headers().get("X-Locale");

        let locale = match req.headers().get("X-Locale") {
            Some(v) => match v.to_str().unwrap() {
                "en" => Locale::EN,
                _ => Locale::RU,
            },
            None => Locale::RU,
        };

        Ok(locale)
    }
}

#[derive(Debug, Deserialize)]
struct JwtUser {
    sub: i64,
}

#[derive(Serialize, Deserialize, Clone, Debug)]
pub struct User {
    id: i64,
    email: String,
    name: Option<String>,
    sname: Option<String>,
    phone: Option<String>,
    state: i32,
    editor: bool,
}

impl From<entities::user::Model> for User {
    fn from(model: entities::user::Model) -> Self {
        let v = serde_json::to_value(&model).unwrap();
        serde_json::from_value(v).unwrap()
    }
}

#[async_trait]
impl<B> FromRequest<B> for User
where
    B: Send,
{
    type Rejection = Response;

    async fn from_request(req: &mut RequestParts<B>) -> Result<Self, Self::Rejection> {
        let cookies = Cookies::from_request(req).await.unwrap();

        let session_cookie = extract_session_cookie(&cookies.get(JWT_COOKIE_NAME));

        let validation = Validation::new(Algorithm::RS256);

        let user_id = match decode::<JwtUser>(
            &session_cookie,
            &DecodingKey::from_rsa_pem(&env::var("AUTH_PUBLIC_KEY").unwrap().into_bytes()).unwrap(),
            &validation,
        ) {
            Ok(token_data) => token_data.claims.sub,
            _ => 0,
        };

        let Extension(pool) = Extension::<DatabaseConnection>::from_request(req)
            .await
            .unwrap();

        let mut user: User = match entities::user::Entity::find_by_id(user_id)
            .one(&pool)
            .await
            .unwrap()
        {
            Some(v) => v.into(),
            _ => User {
                id: 0,
                email: String::from(""),
                name: Some(String::from("")),
                sname: Some(String::from("")),
                phone: Some(String::from("")),
                state: 0,
                editor: false,
            },
        };

        clear_guest_user_email(&mut user);

        Ok(user)
    }
}

fn extract_session_cookie(cookie: &Option<Cookie>) -> String {
    match cookie {
        Some(v) => v.value(),
        None => "",
    }
    .to_string()
}

fn clear_guest_user_email(user: &mut User) {
    let re: Regex =
        Regex::new(r"^guest_(.+)@golovinamari\.com|(.+)@privaterelay\.appleid\.com$").unwrap();

    if re.is_match(&user.email) {
        user.email = String::from("");
    }
}
