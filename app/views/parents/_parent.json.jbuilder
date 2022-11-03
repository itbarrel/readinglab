# frozen_string_literal: true

json.extract! parent, :id, :father_first, :father_last, :father_email, :father_phone, :mother_first, :mother_last,
              :mother_email, :mother_phone, :address,
              :state, :postal_code, :active, :deleted_at,
              :account_id, :city_id, :created_at,
              :updated_at
json.url parent_url(parent, format: :json)
