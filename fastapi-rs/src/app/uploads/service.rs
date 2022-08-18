use aws_sdk_s3::{types::ByteStream, Client};
use bytes::Bytes;
use libvips::ops;
use std::env;
use uuid::Uuid;

pub async fn create(s3_client: Client, preset: &str, vec: Vec<u8>) -> String {
    let key = preset.to_owned() + &Uuid::new_v4().to_string();

    s3_client
        .put_object()
        .bucket(env::var("AWS_BUCKET").unwrap())
        .key(&key)
        .body(ByteStream::from(vec))
        .send()
        .await
        .unwrap();

    key
}

pub fn process_colors_image(bytes: &Bytes) -> Vec<u8> {
    let options = ops::ThumbnailBufferOptions {
        export_profile: "sRGB".to_string(),
        import_profile: "sRGB".to_string(),
        height: 64,
        crop: ops::Interesting::Centre,
        ..ops::ThumbnailBufferOptions::default()
    };
    let img = ops::thumbnail_buffer_with_opts(&bytes, 64, &options).unwrap();

    let options = ops::WebpsaveBufferOptions {
        strip: true,
        ..ops::WebpsaveBufferOptions::default()
    };
    ops::webpsave_buffer_with_opts(&img, &options).unwrap()
}
