# frozen_string_literal: true

class CreateKlassForms < ActiveRecord::Migration[7.0]
  def change
    create_table :klass_forms, id: :uuid do |t|
      t.references :form, null: false, foreign_key: true, type: :uuid
      t.references :klass, null: false, foreign_key: true, type: :uuid
      
      t.timestamps
      t.datetime :deleted_at
    end

    add_index :klass_forms, [:klass_id, :form_id, :deleted_at], unique: true, name: 'klass_forms_id'
  end
end
