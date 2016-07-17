# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160717150501) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "boards", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.text    "users",     array: true
    t.uuid    "client_id"
    t.integer "rows"
    t.integer "columns"
    t.json    "records"
    t.string  "status"
  end

  add_index "boards", ["status"], name: "index_boards_on_status", using: :btree

  create_table "clients", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.text "name"
  end

  create_table "squares", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid    "board_id"
    t.integer "i"
    t.integer "j"
    t.text    "name",     default: ""
    t.json    "state"
  end

  create_table "users", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.text "user_name"
    t.text "first_name"
    t.text "last_name"
    t.text "email"
    t.text "password"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["user_name"], name: "index_users_on_user_name", unique: true, using: :btree

  add_foreign_key "boards", "clients", name: "fk_client_id"
  add_foreign_key "squares", "boards", name: "fk_board_id"
end
