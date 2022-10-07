# frozen_string_literal: true

class CreateVacations < ActiveRecord::Migration[7.0]
  def change
    create_table :vacations, id: :uuid do |t|
      t.string :name
      t.datetime :starting_at
      t.datetime :ending_at
      t.datetime :deleted_at

      t.references :account, null: false, foreign_key: true, type: :uuid
      t.references :vacation_type, null: false, foreign_key: true, type: :uuid
      t.timestamps
    end

    add_index :vacations, [:account_id, :name, :deleted_at], unique: true, name: 'vacations_name'


  end
end
