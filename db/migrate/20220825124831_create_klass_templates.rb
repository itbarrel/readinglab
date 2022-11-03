# frozen_string_literal: true

class CreateKlassTemplates < ActiveRecord::Migration[7.0]
  def change
    create_table :klass_templates, id: :uuid do |t|
      t.string :name
      t.text :description
      t.datetime :start
      t.boolean :monday, default: false
      t.boolean :tuesday, default: false
      t.boolean :wednesday, default: false
      t.boolean :thursday, default: false
      t.boolean :friday, default: false
      t.boolean :saturday, default: false
      t.boolean :sunday, default: false
      t.integer :session_range
      t.integer :duration
      t.integer :max_students, default: Float::INFINITY
      t.jsonb :settings
      t.datetime :deleted_at

      t.references :account, null: false, foreign_key: true, type: :uuid
      t.references :user, foreign_key: true, type: :uuid

      t.timestamps
    end
    add_index :klass_templates, [:account_id, :name, :deleted_at], unique: true, name: 'klass_templates_name'

  end
end
