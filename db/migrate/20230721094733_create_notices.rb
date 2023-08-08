class CreateNotices < ActiveRecord::Migration[7.0]
  def change
    create_table :notices, id: :uuid do |t|
      t.string :reason
      t.text :email_text
      t.references :student, null: false, foreign_key: true, type: :uuid
      t.references :parent, null: false, foreign_key: true, type: :uuid

      t.timestamps
      t.datetime :deleted_at

    end
  end
end
