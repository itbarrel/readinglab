# frozen_string_literal: true

json.extract! student_metting, :id, :created_at, :updated_at
json.url student_metting_url(student_metting, format: :json)
