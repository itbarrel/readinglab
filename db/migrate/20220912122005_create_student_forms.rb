# frozen_string_literal: true

class CreateStudentForms < ActiveRecord::Migration[7.0]
  def change
    create_table :student_forms, id: :uuid do |t|
      t.references :student_class, null: false, foreign_key: true, type: :uuid
      t.references :klass_form, null: false, foreign_key: true, type: :uuid
      
      t.timestamps
      t.datetime :deleted_at
    end

    add_index :student_forms, [:student_class_id, :klass_form_id, :deleted_at], unique: true, name: 'student_forms_id'
  end
end
