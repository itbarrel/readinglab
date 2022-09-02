class CreateReceiptTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :receipt_types, id: :uuid do |t|
      t.string :name
      t.boolean :active
      t.datetime :deleted_at
      t.references :account, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
