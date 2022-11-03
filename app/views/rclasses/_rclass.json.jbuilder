# frozen_string_literal: true

json.extract! rclass, :id, :max_students, :active, :start, :monday, :tuesday, :wednesday, :thursday, :friday,
              :saturday, :sunday, :session_range, :duration,
              :est_end_date, :min_students, :name, :description,
              :deleted_at, :account_id, :user_id, :room_id, :created_at,
              :updated_at
json.url rclass_url(rclass, format: :json)
