class AddColumnInStudents < ActiveRecord::Migration[7.0]
  def change
    add_column :students, :session_credit, :integer, default: 0
    add_column :students, :session_processed_at, :datetime
  end
end
