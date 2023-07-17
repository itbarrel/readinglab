class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications, id: :uuid do |t|
      t.integer  :purpose
      t.references   :record, polymorphic: true, null: false, type: :uuid
      t.references   :user, null: false, foreign_key: true, type: :uuid
       
      t.datetime :seen_at
      t.timestamps
      t.datetime :deleted_at
    end

    add_index :notifications, [:record_id, :record_type, :user_id, :purpose, :deleted_at], unique: true, name: 'notification_index'
  end
end
