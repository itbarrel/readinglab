class CreateForms < ActiveRecord::Migration[7.0]
  def change
    create_table :forms, id: :uuid do |t|
      t.integer :lesson
      t.jsonb :fields
      t.boolean :assessment
      t.string :name
      t.datetime :deleted_at
      t.boolean :active
      t.boolean :attendance
      t.references :account, null: false, foreign_key: true, type: :uuid
    
      t.timestamps
    end
  end
end
