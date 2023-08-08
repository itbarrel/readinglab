class CreateArchiveStudentMeetings < ActiveRecord::Migration[7.0]
  def change
    create_table :archive_student_meetings, id: :uuid do |t|
      t.integer :attendance

      t.references :account, null: false, foreign_key: true, type: :uuid
      t.references :archive_meeting, null: false, foreign_key: true, type: :uuid
      t.references :student, null: false, foreign_key: true, type: :uuid
      
      t.timestamps
      t.datetime :deleted_at
      t.datetime :student_meeting_deleted_at
      t.datetime :student_meeting_created_at
      t.datetime :student_meeting_updated_at
    end

    add_index :archive_student_meetings, [:account_id, :archive_meeting_id, :student_id, :deleted_at], unique: true, name: 'archive_student_meeting_id'
  end
end
