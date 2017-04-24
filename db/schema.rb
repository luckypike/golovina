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

ActiveRecord::Schema.define(version: 20170424090812) do

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

  create_table "kitables", force: :cascade do |t|
    t.bigint "kit_id"
    t.bigint "product_id"
    t.index ["kit_id"], name: "index_kitables_on_kit_id"
    t.index ["product_id"], name: "index_kitables_on_product_id"
  end

  create_table "kits", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "images"
  end

  create_table "lookables", force: :cascade do |t|
    t.bigint "look_id"
    t.string "lookable_type"
    t.bigint "lookable_id"
    t.index ["look_id"], name: "index_lookables_on_look_id"
    t.index ["lookable_type", "lookable_id"], name: "index_lookables_on_lookable_type_and_lookable_id"
  end

  create_table "looks", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "title"
    t.bigint "category_id"
    t.decimal "price"
    t.text "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "images"
    t.string "colors", array: true
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["colors"], name: "index_products_on_colors", using: :gin
  end

  create_table "themables", force: :cascade do |t|
    t.bigint "theme_id"
    t.string "themable_type"
    t.bigint "themable_id"
    t.index ["themable_type", "themable_id"], name: "index_themables_on_themable_type_and_themable_id"
    t.index ["theme_id"], name: "index_themables_on_theme_id"
  end

  create_table "themes", force: :cascade do |t|
    t.string "title"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_themes_on_slug", unique: true
  end

  add_foreign_key "products", "categories"
end
