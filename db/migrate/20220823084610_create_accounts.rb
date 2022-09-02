class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts, id: :uuid do |t|
      t.string :name
      t.string :currency
      t.jsonb :settings, default: {}
      t.string :email
      t.text :address
      t.string :mobile
      t.string :timezone
      t.string :province
      t.integer :postal_code
      t.string :country_code
      t.uuid :parent_id
      t.datetime :deleted_at
      t.boolean :active
      t.boolean :notify_emails
      t.integer :billing_scheme
      t.references :account_type, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
