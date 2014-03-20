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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140311183328) do


  create_table "leaderboards", :id => false, :force => true do |t|
    t.string   "user_race_event_id"
    t.decimal  "distance_run"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "races", :id => false, :force => true do |t|
    t.datetime "start_time"
    t.decimal  "distance"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "user_id"
    t.string   "uuid"
  end

  create_table "user_race_events", :id => false, :force => true do |t|
    t.string   "uuid"
    t.decimal  "longitude"
    t.decimal  "latitude"
    t.decimal  "altitude"
    t.decimal  "horizontal_accuracy"
    t.decimal  "vertical_accuracy"
    t.decimal  "steps"
    t.string   "last_event_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "user_race_id"
  end

  create_table "user_races", :id => false, :force => true do |t|
    t.string   "race_id"
    t.string   "user_id"
    t.string   "uuid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :id => false, :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "uuid"
  end

end
