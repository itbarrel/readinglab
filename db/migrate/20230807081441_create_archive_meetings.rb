class CreateArchiveMeetings < ActiveRecord::Migration[7.0]
  def change
    create_table :archive_meetings, id: :uuid do |t|
      t.datetime :starts_at
      t.datetime :ends_at
      t.boolean :cancel
      t.boolean :hold
      t.references :account, null: false, foreign_key: true, type: :uuid
      t.references :archive_klass, null: false, foreign_key: true, type: :uuid
      
      t.timestamps
      t.datetime :deleted_at
      t.datetime :meeting_deleted_at
      t.datetime :meeting_created_at
      t.datetime :meeting_updated_at
    end
  end
end
