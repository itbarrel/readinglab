# frozen_string_literal: true

class CreateInterviews < ActiveRecord::Migration[7.0]
  def change
    create_table :interviews, id: :uuid do |t|
      t.datetime :date
      t.string :feedback
      t.integer :status

      t.references :account, null: false, foreign_key: true, type: :uuid
      t.references :form, null: false, foreign_key: true, type: :uuid
      t.references :student, null: false, foreign_key: true, type: :uuid
      
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
