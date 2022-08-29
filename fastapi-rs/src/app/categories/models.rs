use super::entities;

pub type CategoryWithTranslation = (
    entities::category::Model,
    Option<entities::category_translation::Model>,
);
