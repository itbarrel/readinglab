class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books, id: :uuid do |t|
      t.string :name
      t.boolean :active
      t.datetime :deleted_at
      t.string :grade
      t.references :account, null: false, foreign_key: true, type: :uuid
      t.references :klass, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
