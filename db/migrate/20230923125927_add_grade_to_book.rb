class AddGradeToBook < ActiveRecord::Migration[7.0]
  def change
    remove_column :books, :grade, :string
    add_reference :books, :grade, foreign_key: true, type: :uuid
  end
end
