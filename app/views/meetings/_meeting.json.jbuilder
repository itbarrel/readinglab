# frozen_string_literal: true

json.extract! meeting, :id, :start, :cancel, :deleted_at, :active, :account_id, :klass_id, :form_id, :created_at,
              :updated_at
json.url meeting_url(meeting, format: :json)
