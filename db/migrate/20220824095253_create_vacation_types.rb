# frozen_string_literal: true

class CreateVacationTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :vacation_types, id: :uuid do |t|
      t.string :name
      t.string :description
      t.datetime :deleted_at
      t.references :account, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end

    add_index :vacation_types, [:account_id, :name, :deleted_at], unique: true, name: 'vacation_types_name'


  end
end
