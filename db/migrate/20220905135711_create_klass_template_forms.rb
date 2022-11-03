# frozen_string_literal: true

class CreateKlassTemplateForms < ActiveRecord::Migration[7.0]
  def change
    create_table :klass_template_forms, id: :uuid do |t|
      t.references :klass_template, null: false, foreign_key: true, type: :uuid
      t.references :form, null: false, foreign_key: true, type: :uuid
      
      t.timestamps
      t.datetime :deleted_at
    end

    add_index :klass_template_forms, [:klass_template_id, :form_id, :deleted_at], unique: true, name: 'klass_template_forms_id'
  end
end
