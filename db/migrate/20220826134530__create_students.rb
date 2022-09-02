class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students, id: :uuid do |t|
      t.string :first
      t.string :last
      t.date :dob
      t.string :grade
      t.string :school
      t.string :sex
      t.string :string
      t.boolean :active
      t.jsonb :settings
      t.string :deleted_at
      t.string :datetime
      t.string :dates
      t.string :programs
      t.integer :status
      t.integer :prepaid_sessions
      t.integer :credit_session
      t.datetime :registration_date
      t.references :account, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
