class CreateVacations < ActiveRecord::Migration[7.0]
  def change
    create_table :vacations, id: :uuid do |t|
      t.date :day
      t.string :name
      t.date :strating_at
      t.date :ending_at
      t.datetime :deleted_at
      t.boolean :active
      t.references :account, null: false, foreign_key: true, type: :uuid
      t.references :vacation_type, null: false, foreign_key: true, type: :uuid
     t.timestamps
    end
  end
end
