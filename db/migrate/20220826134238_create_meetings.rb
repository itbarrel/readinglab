class CreateMeetings < ActiveRecord::Migration[7.0]
  def change
    create_table :meetings, id: :uuid do |t|
      t.datetime :start
      t.boolean :cancel
      t.datetime :deleted_at
      t.boolean :active
      t.references :account, null: false, foreign_key: true, type: :uuid
      t.references :klass, null: false, foreign_key: true, type: :uuid
      t.references :form, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
