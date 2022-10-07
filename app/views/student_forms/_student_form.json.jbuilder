# frozen_string_literal: true

json.extract! student_form, :id, :deleted_at, :student_class_id, :klass_form_id, :created_at, :updated_at
json.url student_form_url(student_form, format: :json)
