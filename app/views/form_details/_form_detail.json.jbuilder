json.extract! form_detail, :id, :form_values, :active, :deleted_at, :parent_types, :user_id, :form_id, :account_id, :parent_id, :created_at, :updated_at
json.url form_detail_url(form_detail, format: :json)
