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

ActiveRecord::Schema.define(version: 2019_03_04_052300) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "layers", force: :cascade do |t|
    t.bigint "profile_id"
    t.string "identifier", null: false
    t.integer "top"
    t.integer "bottom"
    t.string "designation"
    t.decimal "bulk_density"
    t.decimal "ca_co3"
    t.decimal "coarse_fragments"
    t.decimal "ecec"
    t.decimal "conductivity"
    t.decimal "organic_carbon"
    t.decimal "ph_h2o_1"
    t.decimal "ph_kcl_1"
    t.decimal "clay"
    t.decimal "silt"
    t.decimal "sand"
    t.decimal "water_retention"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "ph_h2o_2_5"
    t.decimal "ph_kcl_2_5"
    t.index ["profile_id"], name: "index_layers_on_profile_id"
  end

  create_table "licenses", force: :cascade do |t|
    t.string "name", null: false
    t.string "url", null: false
    t.string "acronym", null: false
    t.string "statement", null: false
    t.boolean "default", default: false, null: false
  end

  create_table "locations", force: :cascade do |t|
    t.geography "coordinates", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}
    t.bigint "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coordinates"], name: "index_locations_on_coordinates", using: :gist
    t.index ["profile_id"], name: "index_locations_on_profile_id"
  end

  create_table "operations", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "profile_ids", default: [], array: true
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "pure", default: true
    t.string "process"
    t.string "error_message"
    t.string "state"
    t.index ["user_id"], name: "index_operations_on_user_id"
  end

  create_table "profile_types", force: :cascade do |t|
    t.boolean "default", default: false, null: false
    t.jsonb "translations", default: {}
  end

  create_table "profiles", force: :cascade do |t|
    t.date "date"
    t.bigint "user_id", null: false
    t.boolean "public", default: true
    t.string "identifier"
    t.string "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "source", null: false
    t.bigint "type_id"
    t.bigint "license_id"
    t.string "country_code", null: false
    t.string "contact"
    t.string "uuid"
    t.index ["license_id"], name: "index_profiles_on_license_id"
    t.index ["type_id"], name: "index_profiles_on_type_id"
    t.index ["user_id"], name: "index_profiles_on_user_id"
    t.index ["uuid"], name: "index_profiles_on_uuid", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.integer "role", default: 0
    t.integer "current_selection", default: [], array: true
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "layers", "profiles"
  add_foreign_key "locations", "profiles"
  add_foreign_key "operations", "users"
  add_foreign_key "profiles", "licenses"
  add_foreign_key "profiles", "profile_types", column: "type_id"
  add_foreign_key "profiles", "users"
end
