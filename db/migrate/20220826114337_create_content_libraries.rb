class CreateContentLibraries < ActiveRecord::Migration[7.0]
  def change
    create_table :content_libraries, id: :uuid do |t|
      t.boolean :public
      t.string :title
      t.datetime :deleted_at
      t.boolean :active
      t.references :account, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
