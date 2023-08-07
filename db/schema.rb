# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_08_03_192806) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "bosses", force: :cascade do |t|
    t.bigint "raid_id"
    t.string "name"
    t.index ["raid_id"], name: "index_bosses_on_raid_id"
  end

  create_table "character_classes", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "character_items", id: false, force: :cascade do |t|
    t.bigint "id"
    t.bigint "character_id"
    t.bigint "item_id"
  end

  create_table "characters", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.bigint "character_class_id"
    t.bigint "primary_spec_id"
    t.bigint "secondary_spec_id"
    t.integer "race"
    t.integer "gender"
    t.index ["character_class_id"], name: "index_characters_on_character_class_id"
    t.index ["primary_spec_id"], name: "index_characters_on_primary_spec_id"
    t.index ["secondary_spec_id"], name: "index_characters_on_secondary_spec_id"
    t.index ["user_id"], name: "index_characters_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.string "image_url"
    t.integer "wow_id"
    t.string "category"
    t.string "subcategory"
    t.integer "item_level"
    t.bigint "boss_id"
    t.bigint "raid_id"
    t.index ["boss_id"], name: "index_items_on_boss_id"
    t.index ["raid_id"], name: "index_items_on_raid_id"
  end

  create_table "jwt_denylist", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.index ["jti"], name: "index_jwt_denylist_on_jti"
  end

  create_table "raids", force: :cascade do |t|
    t.string "name"
    t.string "wow_id"
  end

  create_table "specializations", force: :cascade do |t|
    t.string "name", null: false
    t.integer "role", null: false
    t.string "buffs", default: [], array: true
    t.string "debuffs", default: [], array: true
    t.bigint "character_class_id"
    t.index ["character_class_id"], name: "index_specializations_on_character_class_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username"
    t.integer "wow_id"
    t.string "battletag"
    t.string "access_token"
    t.datetime "access_token_expires_at"
    t.string "access_token_hash"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "characters", "character_classes"
  add_foreign_key "characters", "specializations", column: "primary_spec_id"
  add_foreign_key "characters", "specializations", column: "secondary_spec_id"
  add_foreign_key "characters", "users"
  add_foreign_key "items", "bosses"
  add_foreign_key "items", "raids"
  add_foreign_key "specializations", "character_classes"
end
