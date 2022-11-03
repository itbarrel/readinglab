# frozen_string_literal: true

class CreateReceiptTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :receipt_types, id: :uuid do |t|
      t.string :name
      t.integer :status
      t.references :account, null: false, foreign_key: true, type: :uuid
      
      t.timestamps
      t.datetime :deleted_at
    end
    add_index :receipt_types, [:account_id, :name, :deleted_at], unique: true, name: 'receipt_types_name'

  end
end
