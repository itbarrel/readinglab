class CreateFormFields < ActiveRecord::Migration[7.0]
  def change
    create_table :form_fields, id: :uuid do |t|
      t.string :name
      t.string :description
      t.string :model_key
      t.integer :sort_order
      t.integer :field_type
      t.string :data_type
      t.boolean :necessary
      t.references :form, null: false, foreign_key: true, type: :uuid

      t.timestamps
      t.datetime :deleted_at
    end

    remove_column :forms, :fields
  end
end
