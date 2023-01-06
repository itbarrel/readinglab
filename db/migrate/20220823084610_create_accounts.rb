# frozen_string_literal: true

class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts, id: :uuid do |t|
      t.string :name
      t.string :currency
      t.jsonb :settings, default: {}
      t.string :email
      t.text :address
      t.string :mobile
      t.string :timezone, default: 'Asia/Karachi'
      t.string :province
      t.integer :postal_code
      t.string :country_code
      t.integer :billing_scheme
      t.boolean :notify_emails
      
      t.uuid :parent_id
      t.references :account_type, null: false, foreign_key: true, type: :uuid
      
      t.timestamps
      t.datetime :deleted_at
    end

    add_index :accounts, [:name, :deleted_at], unique: true, name: 'accounts_name'
  end
end
