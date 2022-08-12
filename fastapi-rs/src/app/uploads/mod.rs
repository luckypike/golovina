use aws_sdk_s3::Client;
use axum::{
  extract::Multipart,
  Extension, Json
};

use self::data::UploadData;
mod service;
mod data;

pub async fn create(mut multipart: Multipart, Extension(s3_client): Extension<Client>) -> Json<UploadData> {
  let key = if let Some(file) = multipart.next_field().await.unwrap() {
    service::create(s3_client, file.bytes().await.unwrap()).await
  } else {
    panic!("File cannot be upload!");
  };

  Json(UploadData {
    key
  })
}
