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

ActiveRecord::Schema[7.0].define(version: 2023_04_21_192705) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "follows", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "follower_id"
    t.uuid "following_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["follower_id", "following_user_id"], name: "unique_follows", unique: true
    t.index ["follower_id"], name: "index_follows_on_follower_id"
    t.index ["following_user_id"], name: "index_follows_on_following_user_id"
  end

  create_table "sleeps", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sleeps_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "follows", "users", column: "follower_id"
  add_foreign_key "follows", "users", column: "following_user_id"
  add_foreign_key "sleeps", "users"
end
