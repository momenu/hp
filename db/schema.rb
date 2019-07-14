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

ActiveRecord::Schema.define(version: 2019_07_09_151810) do

  create_table "games", force: :cascade do |t|
    t.integer "win_team"
    t.integer "lose_team"
    t.integer "team1ids"
    t.integer "team2ids"
    t.string "player1"
    t.string "player2"
    t.string "player3"
    t.string "player4"
    t.string "player5"
    t.string "player6"
    t.string "player7"
    t.string "player8"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "match_records", force: :cascade do |t|
    t.integer "win_team"
    t.integer "lose_team"
    t.integer "team1ids"
    t.integer "team2ids"
    t.string "player1"
    t.string "player2"
    t.string "player3"
    t.string "player4"
    t.string "player5"
    t.string "player6"
    t.string "player7"
    t.string "player8"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", force: :cascade do |t|
    t.integer "match_record_id"
    t.integer "user_id"
    t.string "name"
    t.integer "rate"
    t.integer "discord_id"
    t.integer "game_num", default: 0, null: false
    t.integer "win_num", default: 0, null: false
    t.integer "lose_num", default: 0, null: false
    t.integer "position", default: 0, null: false
    t.string "twitter"
    t.integer "game_record_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_record_id"], name: "index_members_on_game_record_id"
    t.index ["match_record_id"], name: "index_members_on_match_record_id"
    t.index ["user_id"], name: "index_members_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_users_on_member_id"
    t.index ["name"], name: "index_users_on_name", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
