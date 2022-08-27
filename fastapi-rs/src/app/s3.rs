use aws_sdk_s3::Client;
use aws_smithy_http::endpoint::Endpoint;
use axum::http::Uri;

pub async fn create_s3_client(endpoint_url: &String) -> Client {
  let endpoint: Uri = endpoint_url.parse().unwrap();

  let config = aws_config::from_env()
    .endpoint_resolver(Endpoint::immutable(endpoint))
    .load().await;

  Client::new(&config)
}
