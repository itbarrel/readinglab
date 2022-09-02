class CreateTrajectoryDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :trajectory_details, id: :uuid do |t|
      t.integer :error_count
      t.integer :wpm
      t.boolean :active
      t.datetime :deleted_at
      t.string :grade
      t.string :season
      t.datetime :entry_date
      t.references :account, null: false, foreign_key: true, type: :uuid
      t.references :student, null: false, foreign_key: true, type: :uuid
      t.references :klass, null: false, foreign_key: true, type: :uuid
      t.references :book, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end