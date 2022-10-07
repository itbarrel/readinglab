# frozen_string_literal: true

json.extract! vacation, :id, :day, :name, :strating_at, :ending_at, :deleted_at, :vacation_type, :active, :boolean,
              :account_id, :references, :created_at, :updated_at
json.url vacation_url(vacation, format: :json)
