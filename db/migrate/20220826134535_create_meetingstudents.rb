class CreateMeetingstudents < ActiveRecord::Migration[7.0]
  def change
    create_table :meetingstudents, id: :uuid do |t|
      t.text :attended
      t.datetime :deleted_at
      t.boolean :active
      t.references :account, null: false, foreign_key: true, type: :uuid
      t.references :meeting, null: false, foreign_key: true, type: :uuid
      t.references :student, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end