# frozen_string_literal: true

class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books, id: :uuid do |t|
      t.string :name
      t.string :grade
      t.datetime :deleted_at
      t.references :account, null: false, foreign_key: true, type: :uuid
      t.references :klass, foreign_key: true, type: :uuid

      t.timestamps
    end
    add_index :books, [:account_id, :name, :deleted_at], unique: true, name: 'book_name'

  end
end
