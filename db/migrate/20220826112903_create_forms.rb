# frozen_string_literal: true

class CreateForms < ActiveRecord::Migration[7.0]
  def change
    create_table :forms, id: :uuid do |t|
      t.string :name
      t.boolean :lessonable, default: false
      t.boolean :attendancable, default: false

      t.references :account, null: false, foreign_key: true, type: :uuid

      t.timestamps
      t.datetime :deleted_at
    end
    add_index :forms, [:account_id, :name, :deleted_at], unique: true, name: 'forms_name'

  end
end
