# frozen_string_literal: true

class CreateTrajectoryDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :trajectory_details, id: :uuid do |t|
      t.integer :error_count
      t.integer :wpm
      t.integer :grade
      t.integer :season
      t.datetime :entry_date
      t.integer :status

      t.references :account, null: false, foreign_key: true, type: :uuid
      t.references :student, null: false, foreign_key: true, type: :uuid
      t.references :klass, null: true, foreign_key: true, type: :uuid
      t.references :book, null: true, foreign_key: true, type: :uuid
      
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
