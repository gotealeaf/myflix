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

ActiveRecord::Schema.define(version: 20140611105152) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "videos", force: true do |t|
    t.string   "name"
    t.string   "year"
    t.string   "duration"
    t.text     "description"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "small_cover_url"
    t.string   "large_cover_url"
  end

  create_table "vs_database_diagrams", id: false, force: true do |t|
    t.string   "name",     limit: 80
    t.text     "diadata"
    t.string   "comment",  limit: 1022
    t.text     "preview"
    t.string   "lockinfo", limit: 80
    t.datetime "locktime"
    t.string   "version",  limit: 80
  end

end
