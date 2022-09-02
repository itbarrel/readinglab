class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms, id: :uuid do |t|
      t.string :capacity
      t.string :integer
      t.string :name
      t.string :color
      t.datetime :deleted_at
      t.boolean :active
      t.references :account, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
