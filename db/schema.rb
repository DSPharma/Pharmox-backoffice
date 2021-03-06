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

ActiveRecord::Schema.define(version: 20170803152604) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "campaigns", force: :cascade do |t|
    t.string "title"
    t.string "product"
    t.datetime "start_at"
    t.datetime "end_at"
    t.string "target"
    t.string "statut_type"
    t.string "campaign_number"
    t.bigint "user_id"
    t.bigint "laboratory_id"
    t.bigint "pharmacy_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["laboratory_id"], name: "index_campaigns_on_laboratory_id"
    t.index ["pharmacy_id"], name: "index_campaigns_on_pharmacy_id"
    t.index ["user_id"], name: "index_campaigns_on_user_id"
  end

  create_table "challenges", force: :cascade do |t|
    t.string "title"
    t.string "product"
    t.datetime "start_at"
    t.datetime "end_at"
    t.string "target"
    t.string "statut_type"
    t.bigint "user_id"
    t.bigint "laboratory_id"
    t.bigint "pharmacy_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["laboratory_id"], name: "index_challenges_on_laboratory_id"
    t.index ["pharmacy_id"], name: "index_challenges_on_pharmacy_id"
    t.index ["user_id"], name: "index_challenges_on_user_id"
  end

  create_table "emails", force: :cascade do |t|
    t.string "email"
    t.bigint "pharmacy_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pharmacy_id"], name: "index_emails_on_pharmacy_id"
  end

  create_table "entries", force: :cascade do |t|
    t.string "kind"
    t.string "title"
    t.string "num_campaign"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "image_base"
    t.bigint "campaign_id"
    t.bigint "entry_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_images_on_campaign_id"
    t.index ["entry_id"], name: "index_images_on_entry_id"
  end

  create_table "inputs", force: :cascade do |t|
    t.string "value"
    t.bigint "entry_id"
    t.bigint "campaign_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_inputs_on_campaign_id"
    t.index ["entry_id"], name: "index_inputs_on_entry_id"
  end

  create_table "laboratories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pharmacies", force: :cascade do |t|
    t.integer "cip"
    t.string "name"
    t.string "address"
    t.integer "postal_code"
    t.string "city"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "enrollement_code"
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.boolean "admin", default: false
    t.string "role"
    t.bigint "laboratory_id"
    t.string "authentication_token"
    t.bigint "pharmacy_id"
    t.index ["authentication_token"], name: "index_users_on_authentication_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["laboratory_id"], name: "index_users_on_laboratory_id"
    t.index ["pharmacy_id"], name: "index_users_on_pharmacy_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "campaigns", "laboratories"
  add_foreign_key "campaigns", "pharmacies"
  add_foreign_key "campaigns", "users"
  add_foreign_key "challenges", "laboratories"
  add_foreign_key "challenges", "pharmacies"
  add_foreign_key "challenges", "users"
  add_foreign_key "emails", "pharmacies"
  add_foreign_key "images", "campaigns"
  add_foreign_key "images", "entries"
  add_foreign_key "inputs", "campaigns"
  add_foreign_key "inputs", "entries"
  add_foreign_key "users", "laboratories"
  add_foreign_key "users", "pharmacies"
end
