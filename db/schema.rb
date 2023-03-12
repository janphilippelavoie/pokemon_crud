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

ActiveRecord::Schema[7.0].define(version: 2023_03_11_145741) do
  create_table "pokemon_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pokemons", force: :cascade do |t|
    t.string "name", null: false
    t.integer "hp", null: false
    t.integer "attack", null: false
    t.integer "defense", null: false
    t.integer "sp_attack", null: false
    t.integer "sp_defense", null: false
    t.integer "speed", null: false
    t.integer "generation", null: false
    t.boolean "legendary", default: false, null: false
    t.integer "type_1_id", null: false
    t.integer "type_2_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type_1_id"], name: "index_pokemons_on_type_1_id"
    t.index ["type_2_id"], name: "index_pokemons_on_type_2_id"
  end

  add_foreign_key "pokemons", "pokemon_types", column: "type_1_id"
  add_foreign_key "pokemons", "pokemon_types", column: "type_2_id"
end
