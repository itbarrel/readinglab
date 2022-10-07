# frozen_string_literal: true

class CreateParents < ActiveRecord::Migration[7.0]
  def change
    create_table :parents, id: :uuid do |t|
      t.string :father_first
      t.string :father_last
      t.string :father_email
      t.string :father_phone
      t.string :mother_first
      t.string :mother_last
      t.string :mother_email
      t.string :mother_phone
      t.text :address
      t.string :state
      t.string :postal_code

      t.references :account, null: false, foreign_key: true, type: :uuid
      t.references :city, null: false, foreign_key: true, type: :uuid
      
      t.timestamps
      t.datetime :deleted_at
    end
    add_index :parents, [:account_id, :father_email, :mother_email, :deleted_at], unique: true, name: 'parents_name'

  end
end
