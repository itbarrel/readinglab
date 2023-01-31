class CreateMessageTemplates < ActiveRecord::Migration[7.0]
  def change
    create_table :message_templates, id: :uuid do |t|
      t.string :name
      t.text :description

      t.references :account, null: false, foreign_key: true, type: :uuid

      t.timestamps
      t.datetime :deleted_at
    end

    add_index :message_templates, [:name, :account_id, :deleted_at], unique: true, name: 'message_template_index'
  end
end
