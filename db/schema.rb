# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_01_24_160103) do
  create_table "inventory_items", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "quantity"
    t.decimal "price"
    t.string "units_per_box"
    t.date "date_arrival"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "joins", force: :cascade do |t|
    t.integer "release_id", null: false
    t.integer "inventory_item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inventory_item_id"], name: "index_joins_on_inventory_item_id"
    t.index ["release_id"], name: "index_joins_on_release_id"
  end

  create_table "releases", force: :cascade do |t|
    t.string "client_name"
    t.string "order_ref"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "invoice_doc"
    t.string "deliverynote_doc"
  end

  create_table "returns", force: :cascade do |t|
    t.integer "sale_id", null: false
    t.integer "inventory_item_id", null: false
    t.integer "quantity_returned"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inventory_item_id"], name: "index_returns_on_inventory_item_id"
    t.index ["sale_id"], name: "index_returns_on_sale_id"
  end

  create_table "sales", force: :cascade do |t|
    t.integer "release_id", null: false
    t.integer "inventory_item_id", null: false
    t.integer "quantity_sold", null: false
    t.decimal "total_amount", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "return_quantity"
    t.boolean "returned"
    t.index ["inventory_item_id"], name: "index_sales_on_inventory_item_id"
    t.index ["release_id"], name: "index_sales_on_release_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.integer "employee_id"
    t.integer "role"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "joins", "inventory_items"
  add_foreign_key "joins", "releases"
  add_foreign_key "returns", "inventory_items"
  add_foreign_key "returns", "sales"
  add_foreign_key "sales", "inventory_items"
  add_foreign_key "sales", "releases"
end
