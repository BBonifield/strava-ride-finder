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

ActiveRecord::Schema.define(:version => 20130126210630) do

  create_table "athletes", :force => true do |t|
    t.integer  "strava_athlete_id"
    t.string   "name"
    t.string   "location"
    t.boolean  "friends_processed", :default => false
    t.boolean  "rides_processed",   :default => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.boolean  "rides_errored",     :default => false
  end

  create_table "coords", :force => true do |t|
    t.integer  "ride_id"
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "rides", :force => true do |t|
    t.integer  "strava_ride_id"
    t.integer  "athlete_id"
    t.string   "name"
    t.binary   "latlng"
    t.float    "average_lat"
    t.float    "average_lng"
    t.boolean  "averaged",       :default => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.boolean  "rides_errored",  :default => false
  end

end
