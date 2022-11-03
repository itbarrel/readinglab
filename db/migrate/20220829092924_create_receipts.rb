# frozen_string_literal: true

class CreateReceipts < ActiveRecord::Migration[7.0]
  def change
    create_table :receipts, id: :uuid do |t|
      t.decimal :amount
      t.string :datetime
      t.integer :leave_count
      t.text :detail
      t.integer :discount
      t.string :discount_reason
      t.integer :sessions_count, default: 8

      t.references :account, null: false, foreign_key: true, type: :uuid
      t.references :student, null: false, foreign_key: true, type: :uuid
      t.references :receipt_type, null: false, foreign_key: true, type: :uuid
      
      t.timestamps
      t.string :deleted_at
    end

  end
end
