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

ActiveRecord::Schema[7.0].define(version: 2024_10_26_165520) do
  create_table "cart_items", id: :decimal, default: "0.0", force: :cascade do |t|
    t.integer "cart_id", precision: 38, null: false
    t.integer "product_id", precision: 38, null: false
    t.integer "quantity", precision: 38, default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "carts", id: :decimal, default: "0.0", force: :cascade do |t|
    t.integer "profile_id", precision: 38, null: false
    t.string "status", default: "active", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", id: :decimal, default: "0.0", force: :cascade do |t|
    t.integer "profile_id", precision: 38, null: false
    t.text "message", null: false
    t.string "notification_type", null: false
    t.string "delivery_method", default: "in_app", null: false
    t.string "status", default: "pending", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer "resource_owner_id", precision: 38, null: false
    t.integer "application_id", precision: 38, null: false
    t.string "token", null: false
    t.integer "expires_in", precision: 38, null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.index ["application_id"], name: "index_oauth_access_grants_on_application_id"
    t.index ["resource_owner_id"], name: "index_oauth_access_grants_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer "resource_owner_id", precision: 38
    t.integer "application_id", precision: 38, null: false
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in", precision: 38
    t.string "scopes"
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.boolean "confidential", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "order_id", precision: 38
    t.integer "product_id", precision: 38
    t.integer "quantity", precision: 38
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "discount", precision: 5, scale: 2, default: "0.0", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer "profile_id", precision: 38
    t.string "status"
    t.decimal "total"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", id: :decimal, default: "0.0", force: :cascade do |t|
    t.integer "order_id", precision: 38, null: false
    t.string "method", null: false
    t.string "status", default: "pending", null: false
    t.string "transaction_id"
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.text "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_images", id: :decimal, default: "0.0", force: :cascade do |t|
    t.integer "product_id", precision: 38, null: false
    t.string "image_url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", id: :decimal, default: "0.0", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.decimal "price", precision: 10, scale: 2
    t.integer "stock", precision: 38
    t.string "category"
    t.string "image_url"
    t.integer "parent_product_id", precision: 38
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "discount", precision: 5, scale: 2, default: "0.0", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string "full_name"
    t.string "email"
    t.string "phone"
    t.text "address"
    t.string "city"
    t.string "state"
    t.string "postal_code"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_role", precision: 38, default: 0
    t.boolean "prefers_email", default: true
    t.boolean "prefers_sms", default: false
    t.boolean "prefers_in_app", default: true
  end

  create_table "related_products", id: :decimal, default: "0.0", force: :cascade do |t|
    t.string "relationship_type", default: "Relacionado"
    t.integer "product_id", precision: 38, null: false
    t.integer "related_product_id", precision: 38, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_related_products_on_product_id"
    t.index ["related_product_id"], name: "index_related_products_on_related_product_id"
  end

  create_table "return_requests", id: :decimal, default: "0.0", force: :cascade do |t|
    t.integer "profile_id", precision: 38, null: false
    t.integer "order_id", precision: 38, null: false
    t.integer "product_id", precision: 38, null: false
    t.text "reason", null: false
    t.string "status", default: "pending", null: false
    t.datetime "requested_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shipments", id: :decimal, default: "0.0", force: :cascade do |t|
    t.integer "order_id", precision: 38
    t.text "address"
    t.string "city"
    t.string "state"
    t.string "postal_code"
    t.string "method"
    t.string "status"
    t.decimal "cost", precision: 10, scale: 2
    t.string "tracking_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "cart_items", "carts", name: "fk_cart_items_cart"
  add_foreign_key "cart_items", "products", name: "fk_cart_items_product"
  add_foreign_key "carts", "profiles", name: "fk_carts_profile"
  add_foreign_key "notifications", "profiles", name: "fk_notifications_profile"
  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "payments", "orders", name: "fk_payments_order"
  add_foreign_key "product_images", "products", name: "fk_product_images_product"
  add_foreign_key "related_products", "products", column: "related_product_id", name: "fk_related_products_related_product"
  add_foreign_key "related_products", "products", name: "fk_related_products_product"
  add_foreign_key "return_requests", "orders", name: "fk_return_requests_order"
  add_foreign_key "return_requests", "products", name: "fk_return_requests_product"
  add_foreign_key "return_requests", "profiles", name: "fk_return_requests_profile"
  add_foreign_key "shipments", "orders", name: "fk_shipments_order"
end
