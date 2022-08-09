use tracing_subscriber::{layer::SubscriberExt, util::SubscriberInitExt};

#[macro_use]
extern crate diesel;
extern crate dotenv;

mod app;
pub mod schema;

#[tokio::main]
async fn main() {
    dotenv::dotenv().ok();
    openssl::init();

    tracing_subscriber::registry()
        .with(tracing_subscriber::fmt::layer())
        .init();

    // let _sentry = sentry::init((
    //     env::var("SENTRY_URL").unwrap(),
    //     sentry::ClientOptions {
    //         release: sentry::release_name!(),
    //         traces_sample_rate: 1.0,
    //     ..Default::default()
    //     }
    // ));

    app::run().await
}
