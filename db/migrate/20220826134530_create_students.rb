# frozen_string_literal: true

class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students, id: :uuid do |t|
      t.string :first_name
      t.string :last_name
      t.date :dob
      t.string :grade
      t.string :sex
      t.string :school
      t.jsonb :settings
      t.string :dates
      t.string :programs
      t.integer :status
      t.integer :prepaid_sessions
      t.integer :credit_session
      t.datetime :registration_date

      t.references :account, null: false, foreign_key: true, type: :uuid
      t.references :parent, null: false, foreign_key: true, type: :uuid
      
      t.timestamps
      t.string :deleted_at
    end
    add_index :students, [:account_id, :first_name, :last_name, :parent_id, :deleted_at], unique: true, name: 'students_name'

  end
end
