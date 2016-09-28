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

ActiveRecord::Schema.define(version: 20160928210811) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blocks", force: :cascade do |t|
    t.string   "name",        limit: 20,                 null: false
    t.integer  "district_id",                            null: false
    t.string   "zipcode",     limit: 9
    t.string   "tour_link",   limit: 255
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "status",                  default: true, null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["district_id"], name: "index_blocks_on_district_id", using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 100,                null: false
    t.integer  "segment_id",                            null: false
    t.boolean  "status",                 default: true, null: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.index ["segment_id"], name: "index_categories_on_segment_id", using: :btree
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name",       limit: 60,                null: false
    t.integer  "state_id",                             null: false
    t.boolean  "status",                default: true, null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.index ["state_id"], name: "index_cities_on_state_id", using: :btree
  end

  create_table "district_groups", force: :cascade do |t|
    t.string   "name",       limit: 60,                null: false
    t.integer  "city_id",                              null: false
    t.boolean  "status",                default: true, null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.index ["city_id"], name: "index_district_groups_on_city_id", using: :btree
  end

  create_table "districts", force: :cascade do |t|
    t.string   "name",              limit: 100,                null: false
    t.integer  "district_group_id",                            null: false
    t.boolean  "status",                        default: true, null: false
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.index ["district_group_id"], name: "index_districts_on_district_group_id", using: :btree
  end

  create_table "pages", force: :cascade do |t|
    t.string   "code",       limit: 50,                null: false
    t.text     "content"
    t.string   "plugin",     limit: 20,                null: false
    t.boolean  "status",                default: true, null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string   "icon",       limit: 40,                null: false
    t.string   "name",       limit: 50,                null: false
    t.boolean  "status",                default: true, null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "segments", force: :cascade do |t|
    t.string   "name",       limit: 100,                null: false
    t.boolean  "status",                 default: true, null: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "specialities", force: :cascade do |t|
    t.string   "name",        limit: 100,                null: false
    t.integer  "category_id",                            null: false
    t.boolean  "status",                  default: true, null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["category_id"], name: "index_specialities_on_category_id", using: :btree
  end

  create_table "states", force: :cascade do |t|
    t.string   "name",         limit: 60,                null: false
    t.string   "abbreviation", limit: 20,                null: false
    t.boolean  "status",                  default: true, null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_foreign_key "blocks", "districts"
  add_foreign_key "categories", "segments"
  add_foreign_key "cities", "states"
  add_foreign_key "district_groups", "cities"
  add_foreign_key "districts", "district_groups"
  add_foreign_key "specialities", "categories"
end
