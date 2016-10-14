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

ActiveRecord::Schema.define(version: 20161014003646) do

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

  create_table "category_markets", force: :cascade do |t|
    t.integer  "category_id", null: false
    t.integer  "market_id",   null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["category_id", "market_id"], name: "index_category_markets_on_category_id_and_market_id", unique: true, using: :btree
    t.index ["category_id"], name: "index_category_markets_on_category_id", using: :btree
    t.index ["market_id"], name: "index_category_markets_on_market_id", using: :btree
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name",       limit: 60,                null: false
    t.integer  "state_id",                             null: false
    t.boolean  "status",                default: true, null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.index ["state_id"], name: "index_cities_on_state_id", using: :btree
  end

  create_table "customer_commons", force: :cascade do |t|
    t.string   "fantasy_name",       limit: 120,                null: false
    t.text     "description"
    t.string   "logo",               limit: 100
    t.string   "image_secure_token", limit: 255
    t.string   "plugin",             limit: 20,                 null: false
    t.boolean  "status",                         default: true, null: false
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string   "name",               limit: 120
    t.integer  "customer_common_id",                             null: false
    t.integer  "block_id",                                       null: false
    t.integer  "customer_type",                                  null: false
    t.string   "document",           limit: 20,                  null: false
    t.string   "address_complement", limit: 255
    t.string   "owner_name",         limit: 120,                 null: false
    t.string   "owner_email",        limit: 100,                 null: false
    t.string   "owner_phone",        limit: 20
    t.string   "contact_email",      limit: 100,                 null: false
    t.string   "contact_phone",                   default: [],                array: true
    t.boolean  "status",                          default: true, null: false
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "additional_info",    limit: 2044
    t.index ["block_id"], name: "index_customers_on_block_id", using: :btree
    t.index ["customer_common_id"], name: "index_customers_on_customer_common_id", using: :btree
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

  create_table "market_payment_methods", force: :cascade do |t|
    t.integer  "market_id",         null: false
    t.integer  "payment_method_id", null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["market_id", "payment_method_id"], name: "index_market_payment_methods_on_market_id_and_payment_method_id", unique: true, using: :btree
    t.index ["market_id"], name: "index_market_payment_methods_on_market_id", using: :btree
    t.index ["payment_method_id"], name: "index_market_payment_methods_on_payment_method_id", using: :btree
  end

  create_table "markets", force: :cascade do |t|
    t.integer  "customer_id",                                      null: false
    t.integer  "segment_id",                                       null: false
    t.integer  "price_category"
    t.boolean  "always_open",                      default: false, null: false
    t.boolean  "delivery",                         default: false, null: false
    t.boolean  "only_delivery",                    default: false, null: false
    t.integer  "estimated_time"
    t.string   "estimated_time_suffix", limit: 10
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.index ["customer_id"], name: "index_markets_on_customer_id", using: :btree
    t.index ["segment_id"], name: "index_markets_on_segment_id", using: :btree
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

  create_table "products", force: :cascade do |t|
    t.string   "name",               limit: 60,                null: false
    t.text     "description"
    t.integer  "market_id",                                    null: false
    t.string   "photo"
    t.string   "image_secure_token"
    t.float    "price"
    t.boolean  "status",                        default: true, null: false
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.index ["market_id"], name: "index_products_on_market_id", using: :btree
  end

  create_table "properties", force: :cascade do |t|
    t.integer  "customer_id",                                     null: false
    t.integer  "block_id",                                        null: false
    t.integer  "property_type",                                   null: false
    t.integer  "commercial_situation",                            null: false
    t.integer  "release_status",                                  null: false
    t.text     "description"
    t.float    "price"
    t.float    "tax"
    t.integer  "area",                                            null: false
    t.float    "square_meter_price"
    t.integer  "rooms",                                           null: false
    t.integer  "bathrooms",                                       null: false
    t.integer  "parking_spaces",                                  null: false
    t.integer  "floor"
    t.integer  "sun_position"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "unit"
    t.float    "maintenance_fee"
    t.boolean  "status",                           default: true, null: false
    t.string   "address_complement",   limit: 255
    t.index ["block_id"], name: "index_properties_on_block_id", using: :btree
    t.index ["customer_id"], name: "index_properties_on_customer_id", using: :btree
  end

  create_table "property_images", force: :cascade do |t|
    t.integer  "property_id",                             null: false
    t.string   "image",       limit: 2044,                null: false
    t.string   "name",        limit: 100,                 null: false
    t.integer  "order",                                   null: false
    t.boolean  "status",                   default: true, null: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.index ["property_id"], name: "index_property_images_on_property_id", using: :btree
  end

  create_table "property_tags", force: :cascade do |t|
    t.integer "property_id", null: false
    t.integer "tag_id",      null: false
    t.index ["property_id", "tag_id"], name: "index_property_tags_on_property_id_and_tag_id", unique: true, using: :btree
    t.index ["property_id"], name: "index_property_tags_on_property_id", using: :btree
    t.index ["tag_id"], name: "index_property_tags_on_tag_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    t.index ["name"], name: "index_roles_on_name", using: :btree
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

  create_table "sponsor_buttons", id: :integer, default: -> { "nextval('sponsors_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer  "customer_id",                null: false
    t.string   "image",                      null: false
    t.integer  "order",                      null: false
    t.boolean  "status",      default: true, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["customer_id"], name: "index_sponsors_on_customer_id", using: :btree
  end

  create_table "sponsor_items", force: :cascade do |t|
    t.string   "sponsorable_type",                null: false
    t.integer  "sponsorable_id",                  null: false
    t.integer  "order",                           null: false
    t.boolean  "status",           default: true, null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["sponsorable_type", "sponsorable_id"], name: "index_sponsor_items_on_sponsorable_type_and_sponsorable_id", using: :btree
  end

  create_table "states", force: :cascade do |t|
    t.string   "name",         limit: 60,                null: false
    t.string   "abbreviation", limit: 20,                null: false
    t.boolean  "status",                  default: true, null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name",       limit: 100,                null: false
    t.string   "plugin",     limit: 20,                 null: false
    t.boolean  "status",                 default: true, null: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
  end

  add_foreign_key "blocks", "districts"
  add_foreign_key "categories", "segments"
  add_foreign_key "category_markets", "categories"
  add_foreign_key "category_markets", "markets"
  add_foreign_key "cities", "states"
  add_foreign_key "customers", "blocks"
  add_foreign_key "customers", "customer_commons"
  add_foreign_key "district_groups", "cities"
  add_foreign_key "districts", "district_groups"
  add_foreign_key "market_payment_methods", "markets"
  add_foreign_key "market_payment_methods", "payment_methods"
  add_foreign_key "markets", "customers"
  add_foreign_key "markets", "segments"
  add_foreign_key "products", "markets"
  add_foreign_key "properties", "blocks"
  add_foreign_key "properties", "customers"
  add_foreign_key "property_images", "properties"
  add_foreign_key "property_tags", "properties"
  add_foreign_key "property_tags", "tags"
  add_foreign_key "specialities", "categories"
  add_foreign_key "sponsor_buttons", "customers"
end
