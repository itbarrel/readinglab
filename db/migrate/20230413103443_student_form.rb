class StudentForm < ActiveRecord::Migration[7.0]
  def change
    add_reference :student_forms, :klass, index: true, type: :uuid, null: false
  end
end
