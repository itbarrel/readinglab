# frozen_string_literal: true

json.extract! book, :id, :name, :active, :deleted_at, :grade, :account_id, :klass_id, :created_at, :updated_at
json.url book_url(book, format: :json)
