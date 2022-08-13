use aws_sdk_s3::Client;
use axum::{
  extract::Multipart,
  Extension, Json, http::StatusCode
};

use self::data::UploadData;

use super::User;
mod service;
mod data;

pub async fn create(
  user: User, mut multipart: Multipart,
  Extension(s3_client): Extension<Client>
) -> Result<Json<UploadData>, StatusCode> {

  if !user.editor {
    return Err(StatusCode::UNAUTHORIZED);
  }

  let key = if let Some(file) = multipart.next_field().await.unwrap() {
    service::create(s3_client, file.bytes().await.unwrap()).await
  } else {
    return Err(StatusCode::INTERNAL_SERVER_ERROR);
  };

  Ok(Json(UploadData {
    key
  }))
}
