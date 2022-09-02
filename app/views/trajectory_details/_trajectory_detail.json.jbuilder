json.extract! trajectory_detail, :id, :error_count, :wpm, :active, :deleted_at, :grade, :season, :entry_date, :account_id, :user_id, :klass_id, :book_id, :created_at, :updated_at
json.url trajectory_detail_url(trajectory_detail, format: :json)
