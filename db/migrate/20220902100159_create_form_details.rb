class CreateFormDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :form_details, id: :uuid do |t|
      t.jsonb :form_values
      t.boolean :active
      t.datetime :deleted_at
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :form, null: false, foreign_key: true, type: :uuid
      t.references :account, null: false, foreign_key: true, type: :uuid
      t.references :parent, polymorphic: true, null: false, type: :uuid

      t.timestamps
    end
  end
end
