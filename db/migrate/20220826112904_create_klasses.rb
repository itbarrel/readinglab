class CreateKlasses < ActiveRecord::Migration[7.0]
  def change
    create_table :klasses, id: :uuid do |t|
      t.integer :max_students
      t.boolean :active
      t.datetime :start
      t.boolean :monday
      t.boolean :tuesday
      t.boolean :wednesday
      t.boolean :thursday
      t.boolean :friday
      t.boolean :saturday
      t.boolean :sunday
      t.integer :session_range
      t.interval :duration
      t.date :est_end_date
      t.integer :min_students
      t.string :name
      t.string :description
      t.datetime :deleted_at
      t.references :account, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :room, null: false, foreign_key: true, type: :uuid
      t.references :klass_template, null: false, foreign_key: true, type: :uuid


      t.timestamps
    end
  end
end
