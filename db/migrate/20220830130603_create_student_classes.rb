class CreateStudentClasses < ActiveRecord::Migration[7.0]
  def change
    create_table :student_classes, id: :uuid do |t|
      t.date :start
      t.datetime :deleted_at
      t.boolean :avtive
      t.references :account, null: false, foreign_key: true, type: :uuid
      t.references :student, null: false, foreign_key: true, type: :uuid
      t.references :klass, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
