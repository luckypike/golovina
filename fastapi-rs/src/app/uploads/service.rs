use std::env;
use aws_sdk_s3::{Client, types::ByteStream};
use bytes::Bytes;
use uuid::Uuid;

pub async fn create(s3_client: Client, file: Bytes) -> String {
  let key = Uuid::new_v4().to_string();

  let res = s3_client.put_object()
  .bucket(env::var("AWS_BUCKET").unwrap())
  .key(&key)
  .body(ByteStream::from(file))
  .send().await;

  dbg!(&res);

  key
}
