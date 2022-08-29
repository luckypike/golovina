use super::entities;

pub type ThemeWithTranslation = (
    entities::theme::Model,
    Option<entities::theme_translation::Model>,
);
