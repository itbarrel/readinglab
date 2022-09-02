json.extract! meetingstudent, :id, :attended, :deleted_at, :active, :account_id, :meeting_id, :user_id, :created_at, :updated_at
json.url meetingstudent_url(meetingstudent, format: :json)
