class RenameObsoleteColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :klasses, :obselete, :obsolete
    rename_column :meetings, :obselete, :obsolete
    rename_column :student_meetings, :obselete, :obsolete
    rename_column :form_details, :obselete, :obsolete

    rename_column :klasses, :obseleted_at, :obsoleted_at
    rename_column :meetings, :obseleted_at, :obsoleted_at
    rename_column :student_meetings, :obseleted_at, :obsoleted_at
    rename_column :form_details, :obseleted_at, :obsoleted_at
  end
end
