# frozen_string_literal: true

json.extract! student_meeting, :id, :created_at, :updated_at
json.url student_meeting_url(student_meeting, format: :json)
