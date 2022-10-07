# frozen_string_literal: true

class CreateKlasses < ActiveRecord::Migration[7.0]
  def change
    create_table :klasses, id: :uuid do |t|
      t.datetime :starts_at
      t.boolean :monday, default: false
      t.boolean :tuesday, default: false
      t.boolean :wednesday, default: false
      t.boolean :thursday, default: false
      t.boolean :friday, default: false
      t.boolean :saturday, default: false
      t.boolean :sunday, default: false
      t.integer :duration
      t.integer :session_range, default: 8
      t.integer :range_type
      t.integer :max_students
      t.integer :min_students
      t.datetime :deleted_at

      t.references :account, null: false, foreign_key: true, type: :uuid
      t.references :teacher, type: :uuid, foreign_key: { to_table: :users }
      t.references :room, foreign_key: true, type: :uuid
      t.references :klass_template, foreign_key: true, type: :uuid
      t.references :attendance_form, type: :uuid, foreign_key: { to_table: :forms }

      t.timestamps
    end

  end
end
