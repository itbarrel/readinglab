class CreateGrades < ActiveRecord::Migration[7.0]
  def change
    create_table :grades, id: :uuid do |t|
      t.string :title

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
