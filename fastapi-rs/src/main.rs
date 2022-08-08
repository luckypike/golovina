use std::env;

#[macro_use]
extern crate diesel;
extern crate dotenv;

mod app;
pub mod schema;

#[tokio::main]
async fn main() {
    dotenv::dotenv().ok();

    let _sentry = sentry::init((
        env::var("SENTRY_URL").unwrap(),
        sentry::ClientOptions {
            release: sentry::release_name!(),
            traces_sample_rate: 1.0,
        ..Default::default()
        }
    ));

    app::run().await
}
