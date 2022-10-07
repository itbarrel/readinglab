# frozen_string_literal: true

json.extract! klass, :id, :max_students, :active, :start, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday,
              :sunday, :session_range, :duration, :est_end_date,
              :min_students, :name, :description, :deleted_at,
              :account_id, :teacher_id, :room_id, :created_at,
              :updated_at
json.url klass_url(klass, format: :json)
