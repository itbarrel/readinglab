# frozen_string_literal: true

class CreateStudentMettings < ActiveRecord::Migration[7.0]
  def change
    create_table :student_mettings, id: :uuid do |t|
      t.integer :attendance
      t.integer :status

      t.references :account, null: false, foreign_key: true, type: :uuid
      t.references :meeting, null: false, foreign_key: true, type: :uuid
      t.references :student, null: false, foreign_key: true, type: :uuid
      
      t.timestamps
      t.datetime :deleted_at
    end

    add_index :student_mettings, [:account_id, :meeting_id, :student_id, :deleted_at], unique: true, name: 'student_meeting_id'
  end
end
