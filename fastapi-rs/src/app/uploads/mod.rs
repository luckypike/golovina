use aws_sdk_s3::Client;
use axum::{
    extract::{Multipart, Path},
    http::StatusCode,
    Extension, Json,
};

use self::data::UploadData;

use super::User;
mod data;
mod service;

pub async fn create(
    Path(preset): Path<String>,
    user: User,
    mut multipart: Multipart,
    Extension(s3_client): Extension<Client>,
) -> Result<Json<UploadData>, StatusCode> {
    if !user.editor {
        return Err(StatusCode::UNAUTHORIZED);
    }

    let key = if let Some(file) = multipart.next_field().await.unwrap() {
        let bytes = file.bytes().await.unwrap();

        match preset.as_str() {
            "colors" => {
                service::create(s3_client, "colors/", service::process_colors_image(&bytes)).await
            }
            _ => service::create(s3_client, "", service::process_colors_image(&bytes)).await,
        }
    } else {
        return Err(StatusCode::INTERNAL_SERVER_ERROR);
    };

    Ok(Json(UploadData { key }))
}
