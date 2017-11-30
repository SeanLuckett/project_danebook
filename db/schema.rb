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

ActiveRecord::Schema.define(version: 20171130160150) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_accounts_on_email"
  end

  create_table "addresses", force: :cascade do |t|
    t.bigint "profile_id"
    t.string "street1", null: false
    t.string "street2"
    t.string "city", null: false
    t.string "state", null: false
    t.string "postcode", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_addresses_on_profile_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.bigint "user_id"
    t.string "first_name"
    t.string "last_name"
    t.string "college"
    t.string "hometown"
    t.string "lives_in"
    t.text "words_live_by"
    t.text "about_me"
    t.string "telephone"
    t.date "birthdate"
    t.integer "sexual_id", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "account_id"
    t.string "first_name"
    t.string "last_name"
    t.string "college"
    t.string "hometown"
    t.string "lives_in"
    t.string "telephone"
    t.text "words_live_by"
    t.text "about_me"
    t.date "birthdate"
    t.integer "sexual_id", default: 0
    t.index ["account_id"], name: "index_users_on_account_id"
  end

  add_foreign_key "addresses", "profiles"
  add_foreign_key "profiles", "users"
  add_foreign_key "users", "accounts"
end
