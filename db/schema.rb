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

ActiveRecord::Schema.define(version: 20141202212653) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "lots", force: true do |t|
    t.integer  "capacity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address"
    t.float    "rate"
  end

  add_index "lots", ["address"], name: "index_lots_on_address", using: :btree
  add_index "lots", ["capacity"], name: "index_lots_on_capacity", using: :btree
  add_index "lots", ["latitude"], name: "index_lots_on_latitude", using: :btree
  add_index "lots", ["longitude"], name: "index_lots_on_longitude", using: :btree

  create_table "parking_events", force: true do |t|
    t.datetime "time_in"
    t.datetime "time_out"
    t.string   "license"
    t.string   "photo_in"
    t.string   "photo_out"
    t.integer  "lot_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "duration"
    t.string   "stripe_txn_id"
    t.integer  "user_id"
    t.string   "error_message"
  end

  add_index "parking_events", ["user_id"], name: "index_parking_events_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "license"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "customer_id"
    t.integer  "last_4"
    t.integer  "exp_month"
    t.integer  "exp_year"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
