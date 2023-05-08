class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments, id: :uuid do |t|
      t.references :student, null: false, foreign_key: true, type: :uuid
      t.references :meeting, null: false, foreign_key: true, type: :uuid
      t.references :receipt, foreign_key: true, type: :uuid

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
