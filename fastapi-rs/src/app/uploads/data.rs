use serde::{Serialize};

#[derive(Serialize)]
pub struct UploadData {
    pub key: String,
}
