# frozen_string_literal: true

json.extract! account, :id, :name, :currency, :string, :settings, :email, :address, :mobile, :string, :timezone,
              :province, :postal_code, :country_code, :parent_id, :deleted_at,
              :active, :notify_emails, :billing_scheme, :account_types_id, :created_at,
              :updated_at
json.url account_url(account, format: :json)
