class AddColumnInStudents < ActiveRecord::Migration[7.0]
  def up
    change_column :students, :credit_session, :integer, default: 0
    add_column :students, :last_session_processed, :datetime
    rename_column :students, :credit_session, :credit_sessions
  end

  def down
    change_column :students, :credit_sessions, :integer
    remove_column :students, :last_session_processed
    rename_column :students, :credit_sessions, :credit_session
  end
end
