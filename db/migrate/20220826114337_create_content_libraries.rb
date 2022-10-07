# frozen_string_literal: true

class CreateContentLibraries < ActiveRecord::Migration[7.0]
  def change
    create_table :content_libraries, id: :uuid do |t|
      t.string :title
      t.boolean :public
      t.datetime :deleted_at
      t.references :account, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
    add_index :content_libraries, [:account_id, :title, :deleted_at], unique: true, name: 'content_libraries_name'

  end
end
