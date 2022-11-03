# frozen_string_literal: true

class CreateAccountTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :account_types, id: :uuid do |t|
      t.string :name
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :account_types, [:name, :deleted_at], unique: true, name: 'account_types_name'
  end
end
