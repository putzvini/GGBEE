# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_09_185029) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "casts", force: :cascade do |t|
    t.string "cast_url"
    t.date "cast_date"
    t.integer "cast_view"
    t.integer "cast_like"
    t.integer "cast_dislike"
    t.integer "cast_comment"
    t.bigint "round_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "cast_time"
    t.index ["round_id"], name: "index_casts_on_round_id"
  end

  create_table "matches", force: :cascade do |t|
    t.string "match_url"
    t.date "match_date"
    t.integer "match_view"
    t.integer "match_like"
    t.integer "match_dislike"
    t.integer "match_comment"
    t.bigint "cast_id"
    t.bigint "blue_team_id"
    t.bigint "red_team_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "match_time"
    t.index ["blue_team_id"], name: "index_matches_on_blue_team_id"
    t.index ["cast_id"], name: "index_matches_on_cast_id"
    t.index ["red_team_id"], name: "index_matches_on_red_team_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "player_name"
    t.string "player_nick"
    t.bigint "team_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "player_twitter"
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "rounds", force: :cascade do |t|
    t.string "round_stage"
    t.string "round_day"
    t.date "round_date"
    t.bigint "tournament_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tournament_id"], name: "index_rounds_on_tournament_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "team_name"
    t.string "team_long_name"
    t.string "team_tag"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "team_twitter"
    t.string "team_twitch"
    t.string "team_youtube"
    t.string "team_ig"
    t.string "team_fb"
    t.integer "team_cup"
    t.string "team_color"
  end

  create_table "tournaments", force: :cascade do |t|
    t.integer "season"
    t.integer "split"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "casts", "rounds"
  add_foreign_key "matches", "casts"
  add_foreign_key "matches", "teams", column: "blue_team_id"
  add_foreign_key "matches", "teams", column: "red_team_id"
  add_foreign_key "players", "teams"
  add_foreign_key "rounds", "tournaments"
end
