class AddObseleteToTables < ActiveRecord::Migration[7.0]
  def change
    add_column :klasses, :obselete, :boolean, default: false
    add_column :meetings, :obselete, :boolean, default: false
    add_column :student_meetings, :obselete, :boolean, default: false
    add_column :form_details, :obselete, :boolean, default: false

    add_column :klasses, :obseleted_at, :datetime
    add_column :meetings, :obseleted_at, :datetime
    add_column :student_meetings, :obseleted_at, :datetime
    add_column :form_details, :obseleted_at, :datetime
  end
end
