# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171030122617) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "carts", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "variant_id"
    t.integer "quantity", default: 1
    t.integer "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_carts_on_user_id"
    t.index ["variant_id"], name: "index_carts_on_variant_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "title"
    t.text "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.bigint "parent_category_id"
    t.integer "state", default: 0
    t.integer "weight", default: 0
    t.index ["parent_category_id"], name: "index_categories_on_parent_category_id"
  end

  create_table "colors", force: :cascade do |t|
    t.string "title"
    t.string "slug"
    t.text "desc"
    t.bigint "parent_color_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color"
    t.string "image"
    t.index ["parent_color_id"], name: "index_colors_on_parent_color_id"
    t.index ["slug"], name: "index_colors_on_slug", unique: true
  end

  create_table "images", force: :cascade do |t|
    t.string "photo"
    t.string "imagable_type"
    t.bigint "imagable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid"
    t.integer "weight", default: 0
    t.index ["imagable_type", "imagable_id"], name: "index_images_on_imagable_type_and_imagable_id"
  end

  create_table "kitables", force: :cascade do |t|
    t.bigint "kit_id"
    t.bigint "product_id"
    t.bigint "variant_id"
    t.index ["kit_id"], name: "index_kitables_on_kit_id"
    t.index ["product_id"], name: "index_kitables_on_product_id"
    t.index ["variant_id"], name: "index_kitables_on_variant_id"
  end

  create_table "kits", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "theme_id"
    t.string "title"
    t.boolean "latest", default: false
    t.integer "state", default: 0
    t.index ["theme_id"], name: "index_kits_on_theme_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "variant_id"
    t.integer "quantity"
    t.integer "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "price"
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["variant_id"], name: "index_order_items_on_variant_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "state", default: 0
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "address"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.bigint "category_id"
    t.decimal "price"
    t.text "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "colors", array: true
    t.bigint "kind_id"
    t.integer "state", default: 0
    t.string "title"
    t.boolean "sale", default: false
    t.boolean "latest", default: false
    t.decimal "price_last"
    t.text "comp"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["colors"], name: "index_products_on_colors", using: :gin
    t.index ["kind_id"], name: "index_products_on_kind_id"
  end

  create_table "similarables", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "similar_product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_similarables_on_product_id"
    t.index ["similar_product_id"], name: "index_similarables_on_similar_product_id"
  end

  create_table "themables", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "theme_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_themables_on_product_id"
    t.index ["theme_id"], name: "index_themables_on_theme_id"
  end

  create_table "themes", force: :cascade do |t|
    t.string "title"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "desc"
    t.string "title_long"
    t.integer "weight", default: 0
    t.integer "state", default: 0
    t.index ["slug"], name: "index_themes_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_token"
    t.string "phone"
    t.string "name"
    t.integer "code"
    t.datetime "code_last"
    t.string "s_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "variants", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "color_id"
    t.jsonb "sizes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "themes"
    t.bigint "category_id"
    t.boolean "out_of_stock", default: false
    t.integer "state", default: 1
    t.index ["category_id"], name: "index_variants_on_category_id"
    t.index ["color_id"], name: "index_variants_on_color_id"
    t.index ["product_id", "color_id"], name: "index_variants_on_product_id_and_color_id", unique: true
    t.index ["product_id"], name: "index_variants_on_product_id"
  end

  create_table "wishlists", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "variant_id"
    t.index ["user_id"], name: "index_wishlists_on_user_id"
    t.index ["variant_id"], name: "index_wishlists_on_variant_id"
  end

  add_foreign_key "carts", "users"
  add_foreign_key "carts", "variants"
  add_foreign_key "kitables", "variants"
  add_foreign_key "kits", "themes"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "variants"
  add_foreign_key "orders", "users"
  add_foreign_key "products", "categories"
  add_foreign_key "similarables", "products"
  add_foreign_key "themables", "products"
  add_foreign_key "themables", "themes"
  add_foreign_key "variants", "categories"
  add_foreign_key "variants", "colors"
  add_foreign_key "variants", "products"
  add_foreign_key "wishlists", "users"
  add_foreign_key "wishlists", "variants"
end
