json.extract! room, :id, :capacity, :integer, :name, :string, :color, :string, :deleted_at, :active, :boolean, :account_id, :references, :created_at, :updated_at
json.url room_url(room, format: :json)
