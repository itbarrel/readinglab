# frozen_string_literal: true

class CreateMeetings < ActiveRecord::Migration[7.0]
  def change
    create_table :meetings, id: :uuid do |t|
      t.datetime :starts_at
      t.datetime :ends_at
      t.boolean :cancel
      t.boolean :hold
      t.references :account, null: false, foreign_key: true, type: :uuid
      t.references :klass, null: false, foreign_key: true, type: :uuid
      
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
