class AddObseleteToTables < ActiveRecord::Migration[7.0]
  def change
    add_column :klasses, :obselete, :boolean, default: false
    add_column :meetings, :obselete, :boolean, default: false
    add_column :student_meetings, :obselete, :boolean, default: false
    add_column :form_details, :obselete, :boolean, default: false
  end
end
