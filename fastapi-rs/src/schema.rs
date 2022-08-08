table! {
    categories (id) {
        id -> Int8,
        slug -> Varchar,
        state -> Int4,
        weight -> Int4,
        variants_and_kits_count -> Int4,
    }
}

table! {
    category_translations (id) {
        id -> Int8,
        category_id -> Int8,
        locale -> Varchar,
        title -> Varchar,
        desc -> Nullable<Text>,
    }
}

table! {
    delivery_cities (id) {
        id -> Int8,
        title -> Varchar,
        door -> Int4,
        door_days -> Varchar,
        storage -> Nullable<Int4>,
        storage_days -> Nullable<Varchar>,
        fast -> Bool,
    }
}

table! {
  order_items (id) {
      id -> Int8,
      order_id -> Int8,
      variant_id -> Int8,
      quantity -> Int4,
  }
}

table! {
  orders (id) {
      id -> Int8,
      state -> Int4,
      user_id -> Int8,
  }
}

table! {
    theme_translations (id) {
        id -> Int8,
        theme_id -> Int8,
        locale -> Varchar,
        title -> Varchar,
        desc -> Nullable<Text>,
    }
}

table! {
    themes (id) {
        id -> Int8,
        slug -> Varchar,
        weight -> Int4,
        state -> Int4,
    }
}

table! {
    users (id) {
        id -> Int8,
        email -> Varchar,
        phone -> Nullable<Varchar>,
        name -> Nullable<Varchar>,
        sname -> Nullable<Varchar>,
        state -> Int4,
        editor -> Bool,
    }
}

table! {
  variants (id) {
      id -> Int8,
      state -> Int4,
      category_id -> Int8,
  }
}

table! {
  wishlists (id) {
      id -> Int8,
      user_id -> Int8,
      variant_id -> Int8,
  }
}

joinable!(category_translations -> categories (category_id));
joinable!(theme_translations -> themes (theme_id));
joinable!(order_items -> orders (order_id));
// joinable!(wishlists -> variants (variant_id));

allow_tables_to_appear_in_same_query!(
    categories,
    category_translations,
);

allow_tables_to_appear_in_same_query!(
    themes,
    theme_translations,
);

allow_tables_to_appear_in_same_query!(
    orders,
    order_items,
    variants,
);

allow_tables_to_appear_in_same_query!(
    wishlists,
    variants,
);
