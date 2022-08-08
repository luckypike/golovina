#[macro_use]
extern crate diesel;
extern crate dotenv;

mod app;
pub mod schema;

#[tokio::main]
async fn main() {
    dotenv::dotenv().ok();
    app::run().await
}
