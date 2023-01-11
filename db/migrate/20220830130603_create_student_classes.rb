# frozen_string_literal: true

class CreateStudentClasses < ActiveRecord::Migration[7.0]
  def change
    create_table :student_classes, id: :uuid do |t|

      t.references :student, null: false, foreign_key: true, type: :uuid
      t.references :klass, null: false, foreign_key: true, type: :uuid
      
      t.timestamps
      t.datetime :deleted_at
    end

    add_index :student_classes, [:student_id, :klass_id, :deleted_at], unique: true, name: 'student_classes_id'
  end
end
