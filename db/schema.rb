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

ActiveRecord::Schema[7.1].define(version: 2025_03_15_152801) do
  create_table "citas", force: :cascade do |t|
    t.integer "paciente_id", precision: 38, null: false
    t.integer "medico_id", precision: 38, null: false
    t.date "fecha"
    t.datetime "hora"
    t.integer "estado", precision: 38
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "especialidad_id", precision: 38
    t.index ["medico_id"], name: "index_citas_on_medico_id"
    t.index ["paciente_id"], name: "index_citas_on_paciente_id"
  end

  create_table "especialidades", force: :cascade do |t|
    t.string "nombre"
    t.string "descripcion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "horario_medicos", force: :cascade do |t|
    t.integer "medico_id", precision: 38, null: false
    t.string "dia"
    t.datetime "hora_inicio"
    t.datetime "hora_fin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "duracion_cita", precision: 38
    t.index ["medico_id"], name: "index_horario_medicos_on_medico_id"
  end

  create_table "medico_especialidades", force: :cascade do |t|
    t.integer "medico_id", precision: 38, null: false
    t.integer "especialidad_id", precision: 38, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["especialidad_id"], name: "index_medico_especialidades_on_especialidad_id"
    t.index ["medico_id"], name: "index_medico_especialidades_on_medico_id"
  end

  create_table "medicos", force: :cascade do |t|
    t.string "registro_profesional"
    t.string "telefono"
    t.string "telefono2"
    t.integer "estado", precision: 38
    t.integer "usuario_id", precision: 38
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nombre"
    t.string "apellido_paterno"
    t.string "apellido_materno"
    t.string "cedula"
    t.string "direccion"
    t.string "movil"
    t.string "email"
    t.index ["usuario_id"], name: "index_medicos_on_usuario_id"
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
    t.integer "application_id", precision: 38
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

  create_table "pacientes", force: :cascade do |t|
    t.integer "estado_civil", precision: 38
    t.string "ocupacion"
    t.date "fecha_nacimiento"
    t.string "lugar_nacimiento"
    t.string "telefono"
    t.integer "tipo_afiliado", precision: 38
    t.integer "tipo_sangre", precision: 38
    t.integer "estado", precision: 38
    t.integer "usuario_id", precision: 38
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nombre"
    t.string "apellido_paterno"
    t.string "apellido_materno"
    t.string "cedula"
    t.string "direccion"
    t.string "movil"
    t.string "email"
    t.index ["usuario_id"], name: "index_pacientes_on_usuario_id"
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "nombre"
    t.string "apellido_paterno"
    t.string "apellido_materno"
    t.string "cedula"
    t.string "direccion"
    t.string "movil"
    t.string "email"
    t.string "password_digest"
    t.integer "rol", precision: 38
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "citas", "especialidades", column: "especialidad_id"
  add_foreign_key "citas", "medicos"
  add_foreign_key "citas", "pacientes"
  add_foreign_key "horario_medicos", "medicos"
  add_foreign_key "medico_especialidades", "especialidades", column: "especialidad_id"
  add_foreign_key "medico_especialidades", "medicos"
  add_foreign_key "medicos", "usuarios"
  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "pacientes", "usuarios"
end
