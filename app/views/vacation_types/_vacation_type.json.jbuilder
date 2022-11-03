# frozen_string_literal: true

json.extract! vacation_type, :id, :name, :description, :deleted_at, :active, :boolean, :account_id, :references,
              :created_at, :updated_at
json.url vacation_type_url(vacation_type, format: :json)
