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

ActiveRecord::Schema.define(version: 20131228211211) do

  create_table "properties", force: true do |t|
    t.string   "number_of_bedrooms"
    t.string   "number_of_bathrooms"
    t.string   "rent_a_week"
    t.string   "address"
    t.string   "street_name"
    t.string   "agentName"
    t.string   "agentPhoneNo"
    t.string   "imageUrl"
    t.string   "thumbnailUrl"
    t.string   "shortDescription"
    t.string   "detailsUrl"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "zone_id"
  end

  create_table "user_watch_zones", force: true do |t|
    t.integer  "user_id"
    t.integer  "zone_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "deviceToken"
    t.string   "deviceType"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "zones", force: true do |t|
    t.string   "postcode"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
