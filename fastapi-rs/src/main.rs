use tracing_subscriber::{layer::SubscriberExt, util::SubscriberInitExt};

use std::env;

extern crate dotenv;

mod app;

#[tokio::main]
async fn main() {
    dotenv::dotenv().ok();

    tracing_subscriber::registry()
        .with(sentry::integrations::tracing::layer())
        .init();

    let _sentry = sentry::init((
        env::var("SENTRY_URL").unwrap(),
        sentry::ClientOptions {
            release: sentry::release_name!(),
            traces_sample_rate: 1.0,
            ..Default::default()
        },
    ));

    app::run().await
}
