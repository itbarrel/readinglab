json.extract! receipt, :id, :amount, :deleted_at, :datetime, :active, :leave_count, :detail, :discount, :discount_reason, :sessions_count, :acoount_id, :user_id, :receipt_type_id, :created_at, :updated_at
json.url receipt_url(receipt, format: :json)
