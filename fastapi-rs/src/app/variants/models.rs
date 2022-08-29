use super::entities;

pub type VariantWithTranslation = (
    entities::variant::Model,
    Option<entities::variant_translation::Model>,
);
