# frozen_string_literal: true

json.extract! interview, :id, :date, :feedback, :status, :deleted_at, :active, :account_id, :form_id, :student_id,
              :created_at, :updated_at
json.url interview_url(interview, format: :json)
