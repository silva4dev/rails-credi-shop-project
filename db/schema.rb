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

ActiveRecord::Schema[7.1].define(version: 2024_04_12_043124) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "street"
    t.string "number"
    t.string "district"
    t.string "city"
    t.string "state"
    t.string "cep"
    t.bigint "proponent_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proponent_id"], name: "index_addresses_on_proponent_id"
  end

  create_table "phones", force: :cascade do |t|
    t.string "number"
    t.integer "type"
    t.string "phoneable_type", null: false
    t.bigint "phoneable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["phoneable_type", "phoneable_id"], name: "index_phones_on_phoneable"
  end

  create_table "proponents", force: :cascade do |t|
    t.string "name"
    t.string "cpf"
    t.date "date_of_birth"
    t.decimal "salary", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cpf"], name: "index_proponents_on_cpf", unique: true
  end

  add_foreign_key "addresses", "proponents"
end
