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

ActiveRecord::Schema[7.0].define(version: 2023_09_06_090851) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "account_types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "deleted_at"], name: "account_types_name", unique: true
  end

  create_table "accounts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "currency"
    t.jsonb "settings", default: {}
    t.string "email"
    t.text "address"
    t.string "mobile"
    t.string "timezone", default: "Asia/Karachi"
    t.string "province"
    t.integer "postal_code"
    t.string "country_code"
    t.integer "billing_scheme"
    t.boolean "notify_emails"
    t.uuid "parent_id"
    t.uuid "account_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["account_type_id"], name: "index_accounts_on_account_type_id"
    t.index ["name", "deleted_at"], name: "accounts_name", unique: true
  end

  create_table "active_storage_attachments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.uuid "record_id", null: false
    t.uuid "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "allocations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.string "allocatee_type", null: false
    t.uuid "allocatee_id", null: false
    t.string "substance_type", null: false
    t.uuid "substance_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["allocatee_type", "allocatee_id"], name: "index_allocations_on_allocatee"
    t.index ["substance_type", "substance_id"], name: "index_allocations_on_substance"
  end

  create_table "archive_form_details", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.jsonb "form_values"
    t.uuid "user_id"
    t.uuid "form_id", null: false
    t.uuid "account_id", null: false
    t.string "parent_type", null: false
    t.uuid "parent_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.datetime "form_detail_deleted_at"
    t.datetime "form_detail_created_at"
    t.datetime "form_detail_updated_at"
    t.index ["account_id"], name: "index_archive_form_details_on_account_id"
    t.index ["form_id"], name: "index_archive_form_details_on_form_id"
    t.index ["parent_type", "parent_id"], name: "index_archive_form_details_on_parent"
    t.index ["user_id"], name: "index_archive_form_details_on_user_id"
  end

  create_table "archive_klasses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "starts_at"
    t.boolean "monday", default: false
    t.boolean "tuesday", default: false
    t.boolean "wednesday", default: false
    t.boolean "thursday", default: false
    t.boolean "friday", default: false
    t.boolean "saturday", default: false
    t.boolean "sunday", default: false
    t.integer "duration"
    t.integer "session_range", default: 8
    t.integer "range_type"
    t.integer "max_students"
    t.integer "min_students", default: 0
    t.datetime "deleted_at"
    t.datetime "klass_deleted_at"
    t.datetime "klass_created_at"
    t.datetime "klass_updated_at"
    t.uuid "account_id", null: false
    t.uuid "teacher_id"
    t.uuid "room_id"
    t.uuid "klass_template_id"
    t.uuid "attendance_form_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_archive_klasses_on_account_id"
    t.index ["attendance_form_id"], name: "index_archive_klasses_on_attendance_form_id"
    t.index ["klass_template_id"], name: "index_archive_klasses_on_klass_template_id"
    t.index ["room_id"], name: "index_archive_klasses_on_room_id"
    t.index ["teacher_id"], name: "index_archive_klasses_on_teacher_id"
  end

  create_table "archive_meetings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.boolean "cancel"
    t.boolean "hold"
    t.uuid "account_id", null: false
    t.uuid "archive_klass_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.datetime "meeting_deleted_at"
    t.datetime "meeting_created_at"
    t.datetime "meeting_updated_at"
    t.index ["account_id"], name: "index_archive_meetings_on_account_id"
    t.index ["archive_klass_id"], name: "index_archive_meetings_on_archive_klass_id"
  end

  create_table "archive_student_meetings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "attendance"
    t.uuid "account_id", null: false
    t.uuid "archive_meeting_id", null: false
    t.uuid "student_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.datetime "student_meeting_deleted_at"
    t.datetime "student_meeting_created_at"
    t.datetime "student_meeting_updated_at"
    t.index ["account_id", "archive_meeting_id", "student_id", "deleted_at"], name: "archive_student_meeting_id", unique: true
    t.index ["account_id"], name: "index_archive_student_meetings_on_account_id"
    t.index ["archive_meeting_id"], name: "index_archive_student_meetings_on_archive_meeting_id"
    t.index ["student_id"], name: "index_archive_student_meetings_on_student_id"
  end

  create_table "books", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "grade"
    t.datetime "deleted_at"
    t.uuid "account_id", null: false
    t.uuid "klass_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id", "name", "deleted_at"], name: "book_name", unique: true
    t.index ["account_id"], name: "index_books_on_account_id"
    t.index ["klass_id"], name: "index_books_on_klass_id"
  end

  create_table "cities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["name", "deleted_at"], name: "cities_name", unique: true
  end

  create_table "content_libraries", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.boolean "public"
    t.datetime "deleted_at"
    t.uuid "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id", "title", "deleted_at"], name: "content_libraries_name", unique: true
    t.index ["account_id"], name: "index_content_libraries_on_account_id"
  end

  create_table "field_values", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "usage"
    t.uuid "form_field_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["form_field_id"], name: "index_field_values_on_form_field_id"
  end

  create_table "form_details", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.jsonb "form_values"
    t.uuid "user_id"
    t.uuid "form_id", null: false
    t.uuid "account_id", null: false
    t.string "parent_type", null: false
    t.uuid "parent_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.uuid "student_id", null: false
    t.boolean "submitted", default: false
    t.boolean "obsolete", default: false
    t.datetime "obsoleted_at"
    t.index ["account_id"], name: "index_form_details_on_account_id"
    t.index ["form_id"], name: "index_form_details_on_form_id"
    t.index ["parent_type", "parent_id"], name: "index_form_details_on_parent"
    t.index ["student_id"], name: "index_form_details_on_student_id"
    t.index ["user_id"], name: "index_form_details_on_user_id"
  end

  create_table "form_fields", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "model_key"
    t.integer "sort_order"
    t.integer "field_type"
    t.string "data_type"
    t.boolean "necessary"
    t.uuid "form_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["form_id"], name: "index_form_fields_on_form_id"
  end

  create_table "forms", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.uuid "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.integer "purpose"
    t.index ["account_id", "name", "deleted_at"], name: "forms_name", unique: true
    t.index ["account_id"], name: "index_forms_on_account_id"
  end

  create_table "interviews", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "date"
    t.string "feedback"
    t.integer "status"
    t.uuid "account_id", null: false
    t.uuid "form_id", null: false
    t.uuid "student_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["account_id"], name: "index_interviews_on_account_id"
    t.index ["form_id"], name: "index_interviews_on_form_id"
    t.index ["student_id"], name: "index_interviews_on_student_id"
  end

  create_table "klass_forms", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "form_id", null: false
    t.uuid "klass_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["form_id"], name: "index_klass_forms_on_form_id"
    t.index ["klass_id", "form_id", "deleted_at"], name: "klass_forms_id", unique: true
    t.index ["klass_id"], name: "index_klass_forms_on_klass_id"
  end

  create_table "klass_templates", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "start"
    t.boolean "monday", default: false
    t.boolean "tuesday", default: false
    t.boolean "wednesday", default: false
    t.boolean "thursday", default: false
    t.boolean "friday", default: false
    t.boolean "saturday", default: false
    t.boolean "sunday", default: false
    t.integer "session_range", default: 8
    t.integer "duration"
    t.integer "max_students"
    t.jsonb "settings"
    t.datetime "deleted_at"
    t.uuid "account_id", null: false
    t.uuid "teacher_id"
    t.uuid "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id", "name", "deleted_at"], name: "klass_templates_name", unique: true
    t.index ["account_id"], name: "index_klass_templates_on_account_id"
    t.index ["room_id"], name: "index_klass_templates_on_room_id"
    t.index ["teacher_id"], name: "index_klass_templates_on_teacher_id"
  end

  create_table "klasses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "starts_at"
    t.boolean "monday", default: false
    t.boolean "tuesday", default: false
    t.boolean "wednesday", default: false
    t.boolean "thursday", default: false
    t.boolean "friday", default: false
    t.boolean "saturday", default: false
    t.boolean "sunday", default: false
    t.integer "duration"
    t.integer "session_range", default: 8
    t.integer "range_type"
    t.integer "max_students"
    t.integer "min_students", default: 0
    t.datetime "deleted_at"
    t.uuid "account_id", null: false
    t.uuid "teacher_id"
    t.uuid "room_id"
    t.uuid "klass_template_id"
    t.uuid "attendance_form_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "obsolete", default: false
    t.datetime "obsoleted_at"
    t.index ["account_id"], name: "index_klasses_on_account_id"
    t.index ["attendance_form_id"], name: "index_klasses_on_attendance_form_id"
    t.index ["klass_template_id"], name: "index_klasses_on_klass_template_id"
    t.index ["room_id"], name: "index_klasses_on_room_id"
    t.index ["teacher_id"], name: "index_klasses_on_teacher_id"
  end

  create_table "meetings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.boolean "cancel"
    t.boolean "hold"
    t.uuid "account_id", null: false
    t.uuid "klass_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.boolean "obsolete", default: false
    t.datetime "obsoleted_at"
    t.index ["account_id"], name: "index_meetings_on_account_id"
    t.index ["klass_id"], name: "index_meetings_on_klass_id"
  end

  create_table "message_templates", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.uuid "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["account_id"], name: "index_message_templates_on_account_id"
    t.index ["name", "account_id", "deleted_at"], name: "message_template_index", unique: true
  end

  create_table "notices", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "reason"
    t.text "email_text"
    t.uuid "student_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["student_id"], name: "index_notices_on_student_id"
  end

  create_table "notifications", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "purpose"
    t.string "record_type", null: false
    t.uuid "record_id", null: false
    t.uuid "user_id", null: false
    t.datetime "seen_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["record_id", "record_type", "user_id", "purpose", "deleted_at"], name: "notification_index", unique: true
    t.index ["record_type", "record_id"], name: "index_notifications_on_record"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "parents", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "father_first"
    t.string "father_last"
    t.string "father_email"
    t.string "father_phone"
    t.string "mother_first"
    t.string "mother_last"
    t.string "mother_email"
    t.string "mother_phone"
    t.text "address"
    t.string "state"
    t.string "postal_code"
    t.uuid "account_id", null: false
    t.uuid "city_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["account_id", "father_email", "mother_email", "deleted_at"], name: "parents_name", unique: true
    t.index ["account_id"], name: "index_parents_on_account_id"
    t.index ["city_id"], name: "index_parents_on_city_id"
  end

  create_table "payments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "student_id", null: false
    t.uuid "meeting_id", null: false
    t.uuid "receipt_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["meeting_id"], name: "index_payments_on_meeting_id"
    t.index ["receipt_id"], name: "index_payments_on_receipt_id"
    t.index ["student_id"], name: "index_payments_on_student_id"
  end

  create_table "receipt_types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.integer "status"
    t.uuid "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["account_id", "name", "deleted_at"], name: "receipt_types_name", unique: true
    t.index ["account_id"], name: "index_receipt_types_on_account_id"
  end

  create_table "receipts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.decimal "amount"
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
    t.string "deleted_at"
    t.index ["account_id"], name: "index_receipts_on_account_id"
    t.index ["receipt_type_id"], name: "index_receipts_on_receipt_type_id"
    t.index ["student_id"], name: "index_receipts_on_student_id"
  end

  create_table "roles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.uuid "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "rooms", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.integer "capacity"
    t.string "color"
    t.uuid "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at", precision: nil
    t.index ["account_id", "name", "deleted_at"], name: "rooms_name", unique: true
    t.index ["account_id"], name: "index_rooms_on_account_id"
  end

  create_table "student_classes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "student_id", null: false
    t.uuid "klass_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["klass_id"], name: "index_student_classes_on_klass_id"
    t.index ["student_id", "klass_id", "deleted_at"], name: "student_classes_id", unique: true
    t.index ["student_id"], name: "index_student_classes_on_student_id"
  end

  create_table "student_forms", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "student_class_id", null: false
    t.uuid "klass_form_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.uuid "klass_id", null: false
    t.index ["klass_form_id"], name: "index_student_forms_on_klass_form_id"
    t.index ["klass_id"], name: "index_student_forms_on_klass_id"
    t.index ["student_class_id", "klass_form_id", "deleted_at"], name: "student_forms_id", unique: true
    t.index ["student_class_id"], name: "index_student_forms_on_student_class_id"
  end

  create_table "student_meetings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "attendance"
    t.uuid "account_id", null: false
    t.uuid "meeting_id", null: false
    t.uuid "student_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.boolean "obsolete", default: false
    t.datetime "obsoleted_at"
    t.index ["account_id", "meeting_id", "student_id", "deleted_at"], name: "student_meeting_id", unique: true
    t.index ["account_id"], name: "index_student_meetings_on_account_id"
    t.index ["meeting_id"], name: "index_student_meetings_on_meeting_id"
    t.index ["student_id"], name: "index_student_meetings_on_student_id"
  end

  create_table "students", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.date "dob"
    t.string "grade"
    t.integer "gender"
    t.string "school"
    t.jsonb "settings"
    t.string "dates"
    t.string "programs"
    t.integer "status"
    t.integer "prepaid_sessions"
    t.integer "credit_sessions", default: 0
    t.datetime "registration_date"
    t.uuid "account_id", null: false
    t.uuid "parent_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "deleted_at"
    t.datetime "last_session_processed"
    t.index ["account_id", "first_name", "last_name", "parent_id", "deleted_at"], name: "students_name", unique: true
    t.index ["account_id"], name: "index_students_on_account_id"
    t.index ["parent_id"], name: "index_students_on_parent_id"
  end

  create_table "trajectory_details", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "error_count"
    t.integer "wpm"
    t.string "grade"
    t.string "season"
    t.datetime "entry_date"
    t.integer "status"
    t.uuid "account_id", null: false
    t.uuid "student_id", null: false
    t.uuid "klass_id"
    t.uuid "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
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
    t.string "postal_code"
    t.string "phone"
    t.string "emergency_name"
    t.string "emergency_contact"
    t.date "date_of_hire"
    t.jsonb "settings"
    t.boolean "undeletable"
    t.date "date_of_inactive"
    t.boolean "external_user"
    t.uuid "account_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "termination_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at", precision: nil
    t.string "profile"
    t.boolean "active", default: true
    t.index ["account_id", "email", "deleted_at"], name: "users_email", unique: true
    t.index ["account_id"], name: "index_users_on_account_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  create_table "vacation_types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "deleted_at"
    t.uuid "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id", "name", "deleted_at"], name: "vacation_types_name", unique: true
    t.index ["account_id"], name: "index_vacation_types_on_account_id"
  end

  create_table "vacations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "starting_at"
    t.datetime "ending_at"
    t.datetime "deleted_at"
    t.uuid "account_id", null: false
    t.uuid "vacation_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id", "name", "deleted_at"], name: "vacations_name", unique: true
    t.index ["account_id"], name: "index_vacations_on_account_id"
    t.index ["vacation_type_id"], name: "index_vacations_on_vacation_type_id"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.uuid "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.text "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "accounts", "account_types"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "archive_form_details", "accounts"
  add_foreign_key "archive_form_details", "forms"
  add_foreign_key "archive_form_details", "users"
  add_foreign_key "archive_klasses", "accounts"
  add_foreign_key "archive_klasses", "forms", column: "attendance_form_id"
  add_foreign_key "archive_klasses", "klass_templates"
  add_foreign_key "archive_klasses", "rooms"
  add_foreign_key "archive_klasses", "users", column: "teacher_id"
  add_foreign_key "archive_meetings", "accounts"
  add_foreign_key "archive_meetings", "archive_klasses"
  add_foreign_key "archive_student_meetings", "accounts"
  add_foreign_key "archive_student_meetings", "archive_meetings"
  add_foreign_key "archive_student_meetings", "students"
  add_foreign_key "books", "accounts"
  add_foreign_key "books", "klasses"
  add_foreign_key "content_libraries", "accounts"
  add_foreign_key "field_values", "form_fields"
  add_foreign_key "form_details", "accounts"
  add_foreign_key "form_details", "forms"
  add_foreign_key "form_details", "users"
  add_foreign_key "form_fields", "forms"
  add_foreign_key "forms", "accounts"
  add_foreign_key "interviews", "accounts"
  add_foreign_key "interviews", "forms"
  add_foreign_key "interviews", "students"
  add_foreign_key "klass_forms", "forms"
  add_foreign_key "klass_forms", "klasses"
  add_foreign_key "klass_templates", "accounts"
  add_foreign_key "klass_templates", "rooms"
  add_foreign_key "klass_templates", "users", column: "teacher_id"
  add_foreign_key "klasses", "accounts"
  add_foreign_key "klasses", "forms", column: "attendance_form_id"
  add_foreign_key "klasses", "klass_templates"
  add_foreign_key "klasses", "rooms"
  add_foreign_key "klasses", "users", column: "teacher_id"
  add_foreign_key "meetings", "accounts"
  add_foreign_key "meetings", "klasses"
  add_foreign_key "message_templates", "accounts"
  add_foreign_key "notices", "students"
  add_foreign_key "notifications", "users"
  add_foreign_key "parents", "accounts"
  add_foreign_key "parents", "cities"
  add_foreign_key "payments", "meetings"
  add_foreign_key "payments", "receipts"
  add_foreign_key "payments", "students"
  add_foreign_key "receipt_types", "accounts"
  add_foreign_key "receipts", "accounts"
  add_foreign_key "receipts", "receipt_types"
  add_foreign_key "receipts", "students"
  add_foreign_key "rooms", "accounts"
  add_foreign_key "student_classes", "klasses"
  add_foreign_key "student_classes", "students"
  add_foreign_key "student_forms", "klass_forms"
  add_foreign_key "student_forms", "student_classes"
  add_foreign_key "student_meetings", "accounts"
  add_foreign_key "student_meetings", "meetings"
  add_foreign_key "student_meetings", "students"
  add_foreign_key "students", "accounts"
  add_foreign_key "students", "parents"
  add_foreign_key "trajectory_details", "accounts"
  add_foreign_key "trajectory_details", "books"
  add_foreign_key "trajectory_details", "klasses"
  add_foreign_key "trajectory_details", "students"
  add_foreign_key "users", "accounts"
  add_foreign_key "vacation_types", "accounts"
  add_foreign_key "vacations", "accounts"
  add_foreign_key "vacations", "vacation_types"
end
