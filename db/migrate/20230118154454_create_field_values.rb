class CreateFieldValues < ActiveRecord::Migration[7.0]
  def change
    create_table :field_values, id: :uuid do |t|
      t.string :name
      t.string :usage
      t.references :form_field, null: false, foreign_key: true, type: :uuid

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
