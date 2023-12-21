class CreateApprovedVacations < ActiveRecord::Migration[7.0]
  def change
    create_table :approved_vacations, id: :uuid do |t|
      t.string :reason
      t.datetime :start_date
      t.datetime :end_date
      t.references :student, null: false, foreign_key: true, type: :uuid
      t.references :account, null: false, foreign_key: true, type: :uuid


      t.timestamps
      t.datetime :deleted_at
    end
  end
end
