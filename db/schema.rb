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

ActiveRecord::Schema[7.0].define(version: 2024_12_24_214334) do
  create_table "cart_items", force: :cascade do |t|
    t.integer "cart_id", precision: 38
    t.integer "product_id", precision: 38
    t.integer "quantity", precision: 38
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "carts", force: :cascade do |t|
    t.integer "profile_id", precision: 38
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoice_details", force: :cascade do |t|
    t.string "actividad_economica", null: false
    t.string "codigo_producto_sin", null: false
    t.string "codigo_producto", null: false
    t.string "descripcion", null: false
    t.decimal "cantidad", precision: 10, scale: 5, null: false
    t.integer "unidad_medida", precision: 38, null: false
    t.decimal "precio_unitario", precision: 15, scale: 5, null: false
    t.decimal "monto_descuento", precision: 15, scale: 2
    t.decimal "sub_total", precision: 15, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "invoice_id", precision: 38
    t.index ["invoice_id"], name: "index_invoice_details_on_invoice_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.string "nit_emisor"
    t.string "razon_social_emisor"
    t.string "municipio"
    t.string "telefono"
    t.string "numero_factura"
    t.string "cuf"
    t.string "cufd"
    t.integer "codigo_sucursal", precision: 38
    t.string "direccion"
    t.integer "codigo_punto_venta", precision: 38
    t.datetime "fecha_emision"
    t.string "nombre_razon_social"
    t.integer "codigo_tipo_documento_identidad", precision: 38
    t.string "numero_documento"
    t.string "complemento"
    t.string "codigo_cliente"
    t.integer "codigo_metodo_pago", precision: 38
    t.string "numero_tarjeta"
    t.decimal "monto_total", precision: 15, scale: 2
    t.decimal "monto_total_sujeto_iva", precision: 15, scale: 2
    t.integer "codigo_moneda", precision: 38
    t.decimal "tipo_cambio", precision: 10, scale: 5
    t.decimal "monto_total_moneda", precision: 15, scale: 2
    t.decimal "monto_gift_card", precision: 15, scale: 2
    t.decimal "descuento_adicional", precision: 15, scale: 2
    t.integer "codigo_excepcion", precision: 38
    t.string "cafc"
    t.string "leyenda"
    t.string "usuario"
    t.integer "codigo_documento_sector", precision: 38
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order_id", precision: 38
    t.index ["order_id"], name: "index_invoices_on_order_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "profile_id", precision: 38
    t.text "message"
    t.string "notification_type"
    t.string "delivery_method"
    t.string "status"
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
    t.string "previous_refresh_token", default: ""
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
    t.decimal "discount", precision: 5, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer "profile_id", precision: 38
    t.string "status"
    t.decimal "total"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.integer "order_id", precision: 38
    t.string "method"
    t.string "status"
    t.string "transaction_id"
    t.decimal "amount", precision: 10, scale: 2
    t.text "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_images", force: :cascade do |t|
    t.integer "product_id", precision: 38
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.decimal "price", precision: 10, scale: 2
    t.integer "stock", precision: 38
    t.string "category"
    t.string "image_url"
    t.integer "parent_product_id", precision: 38
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "file_format"
    t.integer "file_size", precision: 38
    t.decimal "weight", precision: 10, scale: 2
    t.string "dimensions"
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
    t.integer "user_role", precision: 38
    t.boolean "prefers_email"
    t.boolean "prefers_sms"
    t.boolean "prefers_in_app"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "related_products", force: :cascade do |t|
    t.string "relationship_type"
    t.integer "product_id", precision: 38
    t.integer "related_product_id", precision: 38
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "return_requests", force: :cascade do |t|
    t.integer "profile_id", precision: 38
    t.integer "order_id", precision: 38
    t.integer "product_id", precision: 38
    t.text "reason"
    t.string "status"
    t.datetime "requested_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shipments", force: :cascade do |t|
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

  add_foreign_key "cart_items", "carts"
  add_foreign_key "cart_items", "products"
  add_foreign_key "carts", "profiles"
  add_foreign_key "invoice_details", "invoices"
  add_foreign_key "invoices", "orders"
  add_foreign_key "notifications", "profiles"
  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "products"
  add_foreign_key "orders", "profiles"
  add_foreign_key "payments", "orders"
  add_foreign_key "product_images", "products"
  add_foreign_key "related_products", "products"
  add_foreign_key "related_products", "products", column: "related_product_id"
  add_foreign_key "return_requests", "orders"
  add_foreign_key "return_requests", "products"
  add_foreign_key "return_requests", "profiles"
  add_foreign_key "shipments", "orders"
end
