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

ActiveRecord::Schema.define(version: 20170310002718) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.boolean  "completed",  default: false
    t.time     "time"
    t.date     "date"
    t.string   "name"
    t.string   "category"
    t.integer  "user_id"
    t.text     "remarks"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["user_id"], name: "index_events_on_user_id", using: :btree
  end

  create_table "schedules", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "duration"
    t.index ["user_id"], name: "index_schedules_on_user_id", using: :btree
  end

  create_table "tasks", force: :cascade do |t|
    t.integer  "day"
    t.time     "time"
    t.string   "name"
    t.string   "category"
    t.text     "remark"
    t.integer  "schedule_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["schedule_id"], name: "index_tasks_on_schedule_id", using: :btree
  end

  create_table "tokens", force: :cascade do |t|
    t.string   "key"
    t.string   "event"
    t.integer  "target"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "uid"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "events", "users"
  add_foreign_key "schedules", "users"
  add_foreign_key "tasks", "schedules"
end
