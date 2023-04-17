# frozen_string_literal: true

class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms, id: :uuid do |t|
      t.string :name
      t.integer :capacity
      t.string :color

      t.references :account, null: false, foreign_key: true, type: :uuid

      t.timestamps
      t.timestamp :deleted_at
    end

    add_index :rooms, [:account_id, :name, :deleted_at], unique: true, name: 'rooms_name'

  end
end
