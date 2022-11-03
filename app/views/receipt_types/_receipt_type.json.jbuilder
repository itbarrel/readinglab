# frozen_string_literal: true

json.extract! receipt_type, :id, :name, :active, :deleted_at, :account_id, :created_at, :updated_at
json.url receipt_type_url(receipt_type, format: :json)
