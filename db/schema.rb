# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_06_03_091048) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "campaign_communications", force: :cascade do |t|
    t.integer "recipient_id"
    t.text "message"
    t.integer "delivery", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recipient_id"], name: "index_campaign_communications_on_recipient_id"
  end

  create_table "campaign_depositories", force: :cascade do |t|
    t.integer "status", default: 0
    t.integer "company_id"
    t.integer "no_of_contacts", default: 0
    t.integer "operator_id"
    t.string "name"
    t.text "message"
    t.integer "group", default: 0
    t.datetime "scheduled_at"
    t.time "recurring_at"
    t.string "recurring_days", default: [], array: true
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_campaign_depositories_on_company_id"
    t.index ["created_by_id"], name: "index_campaign_depositories_on_created_by_id"
    t.index ["group"], name: "index_campaign_depositories_on_group"
    t.index ["name"], name: "index_campaign_depositories_on_name", unique: true
    t.index ["operator_id"], name: "index_campaign_depositories_on_operator_id"
    t.index ["status"], name: "index_campaign_depositories_on_status"
    t.index ["updated_by_id"], name: "index_campaign_depositories_on_updated_by_id"
  end

  create_table "campaign_recipients", force: :cascade do |t|
    t.integer "status", default: 0
    t.integer "recipient_id"
    t.integer "depository_id"
    t.datetime "archived_at"
    t.jsonb "data", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "phone", null: false
    t.integer "plan_credits", default: 0
    t.boolean "call_forwarding", default: false
    t.boolean "message_forward", default: false
    t.integer "total_credits", default: 0
    t.integer "remaining_credits", default: 0
    t.integer "credit_percentage", default: 0
    t.string "api_token"
    t.integer "plan", default: 1
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_companies_on_email", unique: true
    t.index ["name"], name: "index_companies_on_name", unique: true
    t.index ["phone"], name: "index_companies_on_phone", unique: true
    t.index ["plan"], name: "index_companies_on_plan"
    t.index ["status"], name: "index_companies_on_status"
  end

  create_table "company_plans", force: :cascade do |t|
    t.integer "company_id"
    t.string "month"
    t.integer "credits", default: 0
    t.integer "additional_credits", default: 0
    t.integer "inbounds", default: 0
    t.integer "outbounds", default: 0
    t.integer "voice_inbounds", default: 0
    t.integer "voice_outbounds", default: 0
    t.integer "availed_inbounds", default: 0
    t.integer "availed_outbounds", default: 0
    t.integer "availed_voice_inbounds", default: 0
    t.integer "availed_voice_outbounds", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_company_plans_on_company_id"
  end

  create_table "company_settings", force: :cascade do |t|
    t.text "address"
    t.string "batch_process_default_time", default: "12:00 AM UTC"
    t.string "time_zone", default: "UTC"
    t.integer "company_id"
    t.integer "message_length", default: 0
    t.integer "maxuser", default: 0
    t.integer "max_campaign", default: 0
    t.integer "max_workflow", default: 0
    t.integer "max_menu", default: 0
    t.integer "max_contacts_in_campaign", default: 0
    t.boolean "use_short_code", default: false
    t.boolean "use_destination_link", default: false
    t.boolean "notify_credit_limit", default: false
    t.boolean "notify_user_creation", default: false
    t.boolean "notify_campaign_creation", default: false
    t.boolean "notify_workflow_creation", default: false
    t.boolean "notify_menu_creation", default: false
    t.boolean "sso", default: false
    t.boolean "import_workflows", default: false
    t.boolean "import_menus", default: false
    t.boolean "import_users", default: false
    t.boolean "import_contacts", default: false
    t.boolean "import_campaigns", default: false
    t.date "plan_start_date"
    t.date "plan_end_date"
    t.integer "updated_by_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_company_settings_on_company_id"
    t.index ["updated_by_id"], name: "index_company_settings_on_updated_by_id"
  end

  create_table "platform_operators", force: :cascade do |t|
    t.integer "status", default: 0
    t.string "phone"
    t.datetime "archived_at"
    t.integer "company_id"
    t.string "name"
    t.boolean "short_code", default: false
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_platform_operators_on_company_id"
    t.index ["created_by_id"], name: "index_platform_operators_on_created_by_id"
    t.index ["name"], name: "index_platform_operators_on_name"
    t.index ["phone"], name: "index_platform_operators_on_phone"
    t.index ["status"], name: "index_platform_operators_on_status"
    t.index ["updated_by_id"], name: "index_platform_operators_on_updated_by_id"
  end

  create_table "platform_recipients", force: :cascade do |t|
    t.integer "status", default: 0
    t.string "phone"
    t.datetime "archived_at"
    t.integer "company_id"
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "middle_name"
    t.string "no_of_campaigns", default: "0"
    t.string "keywords", default: [], array: true
    t.text "notes"
    t.integer "gender", default: 1
    t.jsonb "custom_fields", default: {}
    t.string "tags", default: [], array: true
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_platform_recipients_on_company_id"
    t.index ["created_by_id"], name: "index_platform_recipients_on_created_by_id"
    t.index ["first_name"], name: "index_platform_recipients_on_first_name"
    t.index ["last_name"], name: "index_platform_recipients_on_last_name"
    t.index ["phone"], name: "index_platform_recipients_on_phone"
    t.index ["status"], name: "index_platform_recipients_on_status"
    t.index ["updated_by_id"], name: "index_platform_recipients_on_updated_by_id"
  end

  create_table "user_settings", force: :cascade do |t|
    t.integer "user_id"
    t.boolean "notify_workflow", default: false
    t.boolean "notify_menu", default: false
    t.boolean "notify_campaign", default: false
    t.boolean "notify_creditlimit", default: false
    t.string "time_zone", default: "UTC"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_user_settings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "email"
    t.string "first_name", default: "", null: false
    t.string "middle_name"
    t.string "last_name", default: "", null: false
    t.integer "role", default: 0
    t.json "tokens"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.integer "company_id"
    t.integer "status", default: 0
    t.datetime "archived_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["status"], name: "index_users_on_status"
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "workflow_communications", force: :cascade do |t|
    t.integer "status", default: 0
    t.integer "recipient_id"
    t.text "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recipient_id"], name: "index_workflow_communications_on_recipient_id"
  end

  create_table "workflow_declarations", force: :cascade do |t|
    t.integer "depository_id"
    t.text "body"
    t.string "destination_url"
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_by_id"], name: "index_workflow_declarations_on_created_by_id"
    t.index ["depository_id"], name: "index_workflow_declarations_on_depository_id"
    t.index ["updated_by_id"], name: "index_workflow_declarations_on_updated_by_id"
  end

  create_table "workflow_depositories", force: :cascade do |t|
    t.integer "status", default: 0
    t.integer "company_id"
    t.string "keyword"
    t.integer "no_of_contacts", default: 0
    t.integer "operator_id"
    t.boolean "default", default: false
    t.boolean "confidential", default: false
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_workflow_depositories_on_company_id"
    t.index ["created_by_id"], name: "index_workflow_depositories_on_created_by_id"
    t.index ["keyword"], name: "index_workflow_depositories_on_keyword"
    t.index ["operator_id"], name: "index_workflow_depositories_on_operator_id"
    t.index ["status"], name: "index_workflow_depositories_on_status"
    t.index ["updated_by_id"], name: "index_workflow_depositories_on_updated_by_id"
  end

  create_table "workflow_prompts", force: :cascade do |t|
    t.integer "depository_id"
    t.text "body"
    t.integer "order", default: 0
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_by_id"], name: "index_workflow_prompts_on_created_by_id"
    t.index ["depository_id"], name: "index_workflow_prompts_on_depository_id"
    t.index ["updated_by_id"], name: "index_workflow_prompts_on_updated_by_id"
  end

  create_table "workflow_recipients", force: :cascade do |t|
    t.integer "depository_id"
    t.integer "recipient_id"
    t.integer "status", default: 0
    t.integer "progress", default: 0
    t.datetime "reply_at"
    t.datetime "archived_at"
    t.datetime "completed_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["depository_id"], name: "index_workflow_recipients_on_depository_id"
    t.index ["recipient_id"], name: "index_workflow_recipients_on_recipient_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "campaign_communications", "campaign_recipients", column: "recipient_id"
  add_foreign_key "campaign_depositories", "companies"
  add_foreign_key "campaign_depositories", "platform_operators", column: "operator_id"
  add_foreign_key "company_plans", "companies"
  add_foreign_key "company_settings", "companies"
  add_foreign_key "company_settings", "users", column: "updated_by_id"
  add_foreign_key "platform_operators", "companies"
  add_foreign_key "platform_operators", "users", column: "created_by_id"
  add_foreign_key "platform_operators", "users", column: "updated_by_id"
  add_foreign_key "platform_recipients", "companies"
  add_foreign_key "platform_recipients", "users", column: "created_by_id"
  add_foreign_key "platform_recipients", "users", column: "updated_by_id"
  add_foreign_key "user_settings", "users"
  add_foreign_key "users", "companies"
  add_foreign_key "workflow_communications", "workflow_recipients", column: "recipient_id"
  add_foreign_key "workflow_declarations", "users", column: "created_by_id"
  add_foreign_key "workflow_declarations", "users", column: "updated_by_id"
  add_foreign_key "workflow_declarations", "workflow_depositories", column: "depository_id"
  add_foreign_key "workflow_depositories", "companies"
  add_foreign_key "workflow_depositories", "platform_operators", column: "operator_id"
  add_foreign_key "workflow_depositories", "users", column: "created_by_id"
  add_foreign_key "workflow_depositories", "users", column: "updated_by_id"
  add_foreign_key "workflow_prompts", "users", column: "created_by_id"
  add_foreign_key "workflow_prompts", "users", column: "updated_by_id"
  add_foreign_key "workflow_prompts", "workflow_depositories", column: "depository_id"
  add_foreign_key "workflow_recipients", "platform_recipients", column: "recipient_id"
  add_foreign_key "workflow_recipients", "workflow_depositories", column: "depository_id"
end
