class AddStudentInFormDetails < ActiveRecord::Migration[7.0]
  def change
    add_reference :form_details, :student, index: true, type: :uuid, null: false
  end
end
