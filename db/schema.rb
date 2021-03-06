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

ActiveRecord::Schema.define(version: 20131013065555) do

  create_table "big_urls", primary_key: "n_big_url_id", force: true do |t|
    t.string   "vc_real_url",  limit: 2000
    t.string   "vc_short_url", limit: 16
    t.string   "vc_rem",       limit: 500
    t.date     "d_create"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "d_expire",                  default: '2013-11-28'
  end

end
