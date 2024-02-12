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

ActiveRecord::Schema.define(version: 2024_01_26_152748) do

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

  create_table "battles", force: :cascade do |t|
    t.bigint "run_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "boss_id"
    t.index ["run_id"], name: "index_battles_on_run_id"
  end

  create_table "bosses", force: :cascade do |t|
    t.bigint "raid_id"
    t.string "name"
    t.integer "version_id"
    t.index ["raid_id"], name: "index_bosses_on_raid_id"
  end

  create_table "buffs", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "icon"
    t.string "effect_type"
  end

  create_table "character_battles", force: :cascade do |t|
    t.bigint "character_id", null: false
    t.bigint "battle_id", null: false
    t.index ["battle_id"], name: "index_character_battles_on_battle_id"
    t.index ["character_id"], name: "index_character_battles_on_character_id"
  end

  create_table "character_classes", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "character_items", force: :cascade do |t|
    t.bigint "character_id", null: false
    t.bigint "item_id"
    t.boolean "assigned", default: false
    t.index ["character_id"], name: "index_character_items_on_character_id"
    t.index ["item_id"], name: "index_character_items_on_item_id"
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
    t.integer "version_id"
    t.index ["character_class_id"], name: "index_characters_on_character_class_id"
    t.index ["primary_spec_id"], name: "index_characters_on_primary_spec_id"
    t.index ["secondary_spec_id"], name: "index_characters_on_secondary_spec_id"
    t.index ["user_id"], name: "index_characters_on_user_id"
  end

  create_table "drops", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "character_battle_id", null: false
    t.integer "item_id"
    t.boolean "disenchanted", default: false
    t.index ["character_battle_id"], name: "index_drops_on_character_battle_id"
  end

  create_table "friends", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.integer "friend_id"
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
    t.integer "version_id"
    t.index ["boss_id"], name: "index_items_on_boss_id"
    t.index ["raid_id"], name: "index_items_on_raid_id"
    t.index ["version_id"], name: "index_items_on_version_id"
  end

  create_table "jwt_denylist", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.index ["jti"], name: "index_jwt_denylist_on_jti"
  end

  create_table "raids", force: :cascade do |t|
    t.string "name"
    t.string "wow_id"
    t.integer "version_id"
    t.integer "zone_level"
  end

  create_table "runs", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.bigint "raid_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "completed", default: false
    t.index ["raid_id"], name: "index_runs_on_raid_id"
    t.index ["team_id"], name: "index_runs_on_team_id"
  end

  create_table "spec_spells", force: :cascade do |t|
    t.bigint "specialization_id"
    t.bigint "spell_id"
    t.index ["specialization_id"], name: "index_spec_spells_on_specialization_id"
    t.index ["spell_id"], name: "index_spec_spells_on_spell_id"
  end

  create_table "specializations", force: :cascade do |t|
    t.string "name", null: false
    t.integer "role", null: false
    t.bigint "character_class_id"
    t.index ["character_class_id"], name: "index_specializations_on_character_class_id"
  end

  create_table "spells", force: :cascade do |t|
    t.bigint "specialization_id"
    t.bigint "buff_id"
    t.string "icon"
    t.string "description"
    t.string "name"
    t.index ["buff_id"], name: "index_spells_on_buff_id"
    t.index ["specialization_id"], name: "index_spells_on_specialization_id"
  end

  create_table "team_characters", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.bigint "character_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["character_id"], name: "index_team_characters_on_character_id"
    t.index ["team_id"], name: "index_team_characters_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "version_id"
    t.index ["user_id"], name: "index_teams_on_user_id"
    t.index ["version_id"], name: "index_teams_on_version_id"
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
    t.string "uuid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "version_name"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "battles", "runs"
  add_foreign_key "character_battles", "battles"
  add_foreign_key "character_battles", "characters"
  add_foreign_key "character_items", "characters"
  add_foreign_key "character_items", "items"
  add_foreign_key "characters", "character_classes"
  add_foreign_key "characters", "specializations", column: "primary_spec_id"
  add_foreign_key "characters", "specializations", column: "secondary_spec_id"
  add_foreign_key "characters", "users"
  add_foreign_key "drops", "character_battles"
  add_foreign_key "items", "bosses"
  add_foreign_key "items", "raids"
  add_foreign_key "runs", "raids"
  add_foreign_key "runs", "teams"
  add_foreign_key "specializations", "character_classes"
  add_foreign_key "team_characters", "characters"
  add_foreign_key "team_characters", "teams"
  add_foreign_key "teams", "users"
end
