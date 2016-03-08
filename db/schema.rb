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

ActiveRecord::Schema.define(version: 20150301191945) do

  create_table "dog_like_linkers", force: :cascade do |t|
    t.integer "dog_id"
    t.integer "like_id"
  end

  create_table "dog_mix_linkers", force: :cascade do |t|
    t.integer "dog_id"
    t.integer "mix_id"
  end

  create_table "dog_personality_linkers", force: :cascade do |t|
    t.integer "dog_id"
    t.integer "personality_id"
  end

  create_table "dogs", force: :cascade do |t|
    t.string   "name"
    t.string   "image"
    t.datetime "dob"
    t.string   "description"
    t.string   "motto"
    t.boolean  "fixed"
    t.string   "health"
    t.string   "availability"
    t.string   "gender"
    t.integer  "size_id"
    t.integer  "energy_level_id"
    t.integer  "user_id"
  end

  create_table "energy_levels", force: :cascade do |t|
    t.string "value"
  end

  create_table "likes", force: :cascade do |t|
    t.string "value"
  end

  create_table "mixes", force: :cascade do |t|
    t.string "value"
  end

  create_table "personalities", force: :cascade do |t|
    t.string "value"
  end

  create_table "sizes", force: :cascade do |t|
    t.string "value"
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
