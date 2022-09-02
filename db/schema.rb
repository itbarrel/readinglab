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

ActiveRecord::Schema[7.0].define(version: 2022_09_02_100159) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "account_types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "deleted_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "accounts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "currency"
    t.jsonb "settings", default: {}
    t.string "email"
    t.text "address"
    t.string "mobile"
    t.string "timezone"
    t.string "province"
    t.integer "postal_code"
    t.string "country_code"
    t.uuid "parent_id"
    t.datetime "deleted_at"
    t.boolean "active"
    t.boolean "notify_emails"
    t.integer "billing_scheme"
    t.uuid "account_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_type_id"], name: "index_accounts_on_account_type_id"
  end

  create_table "books", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.boolean "active"
    t.datetime "deleted_at"
    t.string "grade"
    t.uuid "account_id", null: false
    t.uuid "klass_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_books_on_account_id"
    t.index ["klass_id"], name: "index_books_on_klass_id"
  end

  create_table "content_libraries", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.boolean "public"
    t.string "title"
    t.datetime "deleted_at"
    t.boolean "active"
    t.uuid "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_content_libraries_on_account_id"
  end

  create_table "form_details", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.jsonb "form_values"
    t.boolean "active"
    t.datetime "deleted_at"
    t.uuid "user_id", null: false
    t.uuid "form_id", null: false
    t.uuid "account_id", null: false
    t.string "parent_type", null: false
    t.uuid "parent_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_form_details_on_account_id"
    t.index ["form_id"], name: "index_form_details_on_form_id"
    t.index ["parent_type", "parent_id"], name: "index_form_details_on_parent"
    t.index ["user_id"], name: "index_form_details_on_user_id"
  end

  create_table "forms", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "lesson"
    t.jsonb "fields"
    t.boolean "assessment"
    t.string "name"
    t.datetime "deleted_at"
    t.boolean "active"
    t.boolean "attendance"
    t.uuid "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_forms_on_account_id"
  end

  create_table "interviews", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "date"
    t.string "feedback"
    t.integer "status"
    t.datetime "deleted_at"
    t.boolean "active"
    t.uuid "account_id", null: false
    t.uuid "form_id", null: false
    t.uuid "student_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_interviews_on_account_id"
    t.index ["form_id"], name: "index_interviews_on_form_id"
    t.index ["student_id"], name: "index_interviews_on_student_id"
  end

  create_table "klass_templates", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "max_students"
    t.boolean "active"
    t.datetime "start"
    t.boolean "monday"
    t.boolean "tuesday"
    t.boolean "wednesday"
    t.boolean "thursday"
    t.boolean "friday"
    t.boolean "saturday"
    t.boolean "sunday"
    t.jsonb "settings"
    t.integer "session_range"
    t.integer "duration"
    t.integer "min_students"
    t.string "name"
    t.text "description"
    t.datetime "deleted_at"
    t.uuid "account_id", null: false
    t.uuid "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_klass_templates_on_account_id"
    t.index ["user_id"], name: "index_klass_templates_on_user_id"
  end

  create_table "klasses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "max_students"
    t.boolean "active"
    t.datetime "start"
    t.boolean "monday"
    t.boolean "tuesday"
    t.boolean "wednesday"
    t.boolean "thursday"
    t.boolean "friday"
    t.boolean "saturday"
    t.boolean "sunday"
    t.integer "session_range"
    t.interval "duration"
    t.date "est_end_date"
    t.integer "min_students"
    t.string "name"
    t.string "description"
    t.datetime "deleted_at"
    t.uuid "account_id", null: false
    t.uuid "user_id", null: false
    t.uuid "room_id", null: false
    t.uuid "klass_template_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_klasses_on_account_id"
    t.index ["klass_template_id"], name: "index_klasses_on_klass_template_id"
    t.index ["room_id"], name: "index_klasses_on_room_id"
    t.index ["user_id"], name: "index_klasses_on_user_id"
  end

  create_table "meetings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "start"
    t.boolean "cancel"
    t.datetime "deleted_at"
    t.boolean "active"
    t.uuid "account_id", null: false
    t.uuid "klass_id", null: false
    t.uuid "form_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_meetings_on_account_id"
    t.index ["form_id"], name: "index_meetings_on_form_id"
    t.index ["klass_id"], name: "index_meetings_on_klass_id"
  end

  create_table "meetingstudents", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "attended"
    t.datetime "deleted_at"
    t.boolean "active"
    t.uuid "account_id", null: false
    t.uuid "meeting_id", null: false
    t.uuid "student_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_meetingstudents_on_account_id"
    t.index ["meeting_id"], name: "index_meetingstudents_on_meeting_id"
    t.index ["student_id"], name: "index_meetingstudents_on_student_id"
  end

  create_table "receipt_types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.boolean "active"
    t.datetime "deleted_at"
    t.uuid "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_receipt_types_on_account_id"
  end

  create_table "receipts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.decimal "amount"
    t.string "deleted_at"
    t.string "datetime"
    t.boolean "active"
    t.integer "leave_count"
    t.text "detail"
    t.integer "discount"
    t.string "discount_reason"
    t.integer "sessions_count", default: 8
    t.uuid "account_id", null: false
    t.uuid "student_id", null: false
    t.uuid "receipt_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_receipts_on_account_id"
    t.index ["receipt_type_id"], name: "index_receipts_on_receipt_type_id"
    t.index ["student_id"], name: "index_receipts_on_student_id"
  end

  create_table "rooms", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "capacity"
    t.string "integer"
    t.string "name"
    t.string "color"
    t.datetime "deleted_at"
    t.boolean "active"
    t.uuid "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_rooms_on_account_id"
  end

  create_table "student_classes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.date "start"
    t.datetime "deleted_at"
    t.boolean "avtive"
    t.uuid "account_id", null: false
    t.uuid "student_id", null: false
    t.uuid "klass_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_student_classes_on_account_id"
    t.index ["klass_id"], name: "index_student_classes_on_klass_id"
    t.index ["student_id"], name: "index_student_classes_on_student_id"
  end

  create_table "students", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first"
    t.string "last"
    t.date "dob"
    t.string "grade"
    t.string "school"
    t.string "sex"
    t.string "string"
    t.boolean "active"
    t.jsonb "settings"
    t.string "deleted_at"
    t.string "datetime"
    t.string "dates"
    t.string "programs"
    t.integer "status"
    t.integer "prepaid_sessions"
    t.integer "credit_session"
    t.datetime "registration_date"
    t.uuid "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_students_on_account_id"
  end

  create_table "trajectory_details", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "error_count"
    t.integer "wpm"
    t.boolean "active"
    t.datetime "deleted_at"
    t.string "grade"
    t.string "season"
    t.datetime "entry_date"
    t.uuid "account_id", null: false
    t.uuid "student_id", null: false
    t.uuid "klass_id", null: false
    t.uuid "book_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_trajectory_details_on_account_id"
    t.index ["book_id"], name: "index_trajectory_details_on_book_id"
    t.index ["klass_id"], name: "index_trajectory_details_on_klass_id"
    t.index ["student_id"], name: "index_trajectory_details_on_student_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.boolean "active"
    t.string "postal_code"
    t.string "phone"
    t.string "emergency_name"
    t.string "emergency_contact"
    t.date "date_of_hire"
    t.jsonb "settings"
    t.boolean "undeletable"
    t.date "date_of_inactive"
    t.boolean "external_user"
    t.datetime "deleted_at", precision: nil
    t.uuid "account_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.integer "role"
    t.string "termination_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_users_on_account_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vacation_types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "deleted_at"
    t.boolean "active"
    t.uuid "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_vacation_types_on_account_id"
  end

  create_table "vacations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.date "day"
    t.string "name"
    t.date "strating_at"
    t.date "ending_at"
    t.datetime "deleted_at"
    t.boolean "active"
    t.uuid "account_id", null: false
    t.uuid "vacation_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_vacations_on_account_id"
    t.index ["vacation_type_id"], name: "index_vacations_on_vacation_type_id"
  end

  add_foreign_key "accounts", "account_types"
  add_foreign_key "books", "accounts"
  add_foreign_key "books", "klasses"
  add_foreign_key "content_libraries", "accounts"
  add_foreign_key "form_details", "accounts"
  add_foreign_key "form_details", "forms"
  add_foreign_key "form_details", "users"
  add_foreign_key "forms", "accounts"
  add_foreign_key "interviews", "accounts"
  add_foreign_key "interviews", "forms"
  add_foreign_key "interviews", "students"
  add_foreign_key "klass_templates", "accounts"
  add_foreign_key "klass_templates", "users"
  add_foreign_key "klasses", "accounts"
  add_foreign_key "klasses", "klass_templates"
  add_foreign_key "klasses", "rooms"
  add_foreign_key "klasses", "users"
  add_foreign_key "meetings", "accounts"
  add_foreign_key "meetings", "forms"
  add_foreign_key "meetings", "klasses"
  add_foreign_key "meetingstudents", "accounts"
  add_foreign_key "meetingstudents", "meetings"
  add_foreign_key "meetingstudents", "students"
  add_foreign_key "receipt_types", "accounts"
  add_foreign_key "receipts", "accounts"
  add_foreign_key "receipts", "receipt_types"
  add_foreign_key "receipts", "students"
  add_foreign_key "rooms", "accounts"
  add_foreign_key "student_classes", "accounts"
  add_foreign_key "student_classes", "klasses"
  add_foreign_key "student_classes", "students"
  add_foreign_key "students", "accounts"
  add_foreign_key "trajectory_details", "accounts"
  add_foreign_key "trajectory_details", "books"
  add_foreign_key "trajectory_details", "klasses"
  add_foreign_key "trajectory_details", "students"
  add_foreign_key "users", "accounts"
  add_foreign_key "vacation_types", "accounts"
  add_foreign_key "vacations", "accounts"
  add_foreign_key "vacations", "vacation_types"
end
