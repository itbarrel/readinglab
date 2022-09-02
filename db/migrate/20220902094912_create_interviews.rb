class CreateInterviews < ActiveRecord::Migration[7.0]
  def change
    create_table :interviews, id: :uuid do |t|
      t.datetime :date
      t.string :feedback
      t.integer :status
      t.datetime :deleted_at
      t.boolean :active
      t.references :account, null: false, foreign_key: true, type: :uuid
      t.references :form, null: false, foreign_key: true, type: :uuid
      t.references :student, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
