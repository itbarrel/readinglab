# frozen_string_literal: true

json.extract! klass_template, :id, :max_students, :active, :start, :monday, :tuesday, :wednesday, :thursday, :friday,
              :saturday, :sunday, :settings, :session_range, :duration,
              :min_students, :name, :description, :deleted_at,
              :account_id, :user_id, :room_id, :created_at,
              :updated_at
json.url klass_template_url(klass_template, format: :json)
