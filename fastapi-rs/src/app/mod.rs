mod db;
mod delivery_cities;
mod sessions;
mod locale;

mod categories;
mod orders;
mod users;
mod wishlists;

use std::{net::SocketAddr, env};
use lazy_static::lazy_static;
use regex::Regex;
use axum::{
    extract::{Extension, FromRequest, RequestParts},
    routing::get,
    Router, async_trait, response::Response
};
use diesel::{r2d2::{PooledConnection, ConnectionManager}, PgConnection};
use jsonwebtoken::{decode, Validation, DecodingKey, Algorithm};
use serde::Deserialize;
use tower_cookies::{CookieManagerLayer, Cookies, Cookie};
use self::{users::models::User, db::ConnectionPool};
use crate::schema::users::dsl::*;
use diesel::prelude::*;

const JWT_COOKIE_NAME: &str = "_golovina_jwt";

pub async fn run() {
    let pool = db::create_pool(&env::var("DATABASE_URL").unwrap());

    let app = Router::new()
        .route("/", get(|| async { "hi" }))
        .nest(
            "/api",
            Router::new()
                .route("/session", get(sessions::show))
                .route("/delivery-cities", get(delivery_cities::index))
        )
        .layer(CookieManagerLayer::new())
        .layer(Extension(pool));

    let addr = SocketAddr::from(([0, 0, 0, 0], 3001));

    // let qq = pool.get().await.unwrap();

    axum::Server::bind(&addr)
        .serve(app.into_make_service())
        .await
        .unwrap();
}

#[derive(Debug)]
pub enum Locale {
    RU,
    EN
}

#[async_trait]
impl<B> FromRequest<B> for Locale
where
    B: Send
{
    type Rejection = Response;

    async fn from_request(req: &mut RequestParts<B>) -> Result<Self, Self::Rejection> {
        // let qq = req.headers().get("X-Locale");

        let locale = match req.headers().get("X-Locale") {
            Some(v) => match v.to_str().unwrap() {
                "en" => Locale::EN,
                _ => Locale::RU
            },
            None => Locale::RU

        };

        Ok(locale)
    }
}


pub struct DatabaseConnection(PooledConnection<ConnectionManager<PgConnection>>);

#[async_trait]
impl<B> FromRequest<B> for DatabaseConnection
where
    B: Send
{
    type Rejection = Response;

    async fn from_request(req: &mut RequestParts<B>) -> Result<Self, Self::Rejection> {
        let Extension(pool) = Extension::<ConnectionPool>::from_request(req).await.unwrap();

        let conn = pool.get().unwrap();
        Ok(Self(conn))
    }
}

#[derive(Debug, Deserialize)]
struct JwtUser {
    sub: i64
}

#[async_trait]
impl<B> FromRequest<B> for User
where
    B: Send
{
    type Rejection = Response;

    async fn from_request(req: &mut RequestParts<B>) -> Result<Self, Self::Rejection> {
        let cookies = Cookies::from_request(req).await.unwrap();

        let session_cookie = extract_session_cookie(&cookies.get(JWT_COOKIE_NAME));

        let validation = Validation::new(Algorithm::RS256);
        // validation.validate_exp = false;

        let user_id = match decode::<JwtUser>(
            &session_cookie,
            &DecodingKey::from_rsa_pem(&env::var("AUTH_PUBLIC_KEY").unwrap().into_bytes()).unwrap(),
            &validation
        ) {
            Ok(token_data) => token_data.claims.sub,
            _ => 0
        };

        let Extension(pool) = Extension::<ConnectionPool>::from_request(req).await.unwrap();

        let mut conn = pool.get().unwrap();

        let mut user: User = users.find(user_id).first::<User>(&mut conn).unwrap_or(User {
            id: 0,
            email: String::from(""),
            name: Some(String::from("")),
            sname: Some(String::from("")),
            phone: Some(String::from("")),
            state: 0,
            editor: false,
        });

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
    lazy_static! {
        static ref RE: Regex = Regex::new(r"^guest_(.+)@golovinamari\.com|(.+)@privaterelay\.appleid\.com$").unwrap();
    }

    if RE.is_match(&user.email) {
        user.email = String::from("");
    }
}
