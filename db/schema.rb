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

ActiveRecord::Schema.define(version: 20170814160629) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "title"
    t.string "slug"
    t.text "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_categories_on_slug", unique: true
  end

  create_table "colors", force: :cascade do |t|
    t.string "title"
    t.string "slug"
    t.text "desc"
    t.bigint "parent_color_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_color_id"], name: "index_colors_on_parent_color_id"
    t.index ["slug"], name: "index_colors_on_slug", unique: true
  end

  create_table "kinds", force: :cascade do |t|
    t.string "title"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_kinds_on_category_id"
  end

  create_table "kitables", force: :cascade do |t|
    t.bigint "kit_id"
    t.bigint "product_id"
    t.index ["kit_id"], name: "index_kitables_on_kit_id"
    t.index ["product_id"], name: "index_kitables_on_product_id"
  end

  create_table "kits", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "images"
    t.bigint "theme_id"
    t.index ["theme_id"], name: "index_kits_on_theme_id"
  end

  create_table "products", force: :cascade do |t|
    t.bigint "category_id"
    t.decimal "price"
    t.text "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "images"
    t.string "colors", array: true
    t.bigint "kind_id"
    t.integer "state", default: 0
    t.string "title"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["colors"], name: "index_products_on_colors", using: :gin
    t.index ["kind_id"], name: "index_products_on_kind_id"
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
    t.string "title_short"
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
    t.index ["category_id"], name: "index_variants_on_category_id"
    t.index ["color_id"], name: "index_variants_on_color_id"
    t.index ["product_id", "color_id"], name: "index_variants_on_product_id_and_color_id", unique: true
    t.index ["product_id"], name: "index_variants_on_product_id"
  end

  create_table "wishlists", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_wishlists_on_product_id"
    t.index ["user_id"], name: "index_wishlists_on_user_id"
  end

  add_foreign_key "kinds", "categories"
  add_foreign_key "kits", "themes"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "kinds"
  add_foreign_key "themables", "products"
  add_foreign_key "themables", "themes"
  add_foreign_key "variants", "categories"
  add_foreign_key "variants", "colors"
  add_foreign_key "variants", "products"
  add_foreign_key "wishlists", "products"
  add_foreign_key "wishlists", "users"
end
