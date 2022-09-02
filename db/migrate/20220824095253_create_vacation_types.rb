class CreateVacationTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :vacation_types, id: :uuid do |t|
      t.string :name
      t.string :description
      t.datetime :deleted_at
      t.boolean :active
      t.references :account, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
