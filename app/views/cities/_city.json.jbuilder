# frozen_string_literal: true

json.extract! city, :id, :name, :deleted_at, :created_at, :updated_at
json.url city_url(city, format: :json)
