class AddAccountToGrade < ActiveRecord::Migration[7.0]
  def change
    Book.update_all(grade_id: nil)
    Grade.delete_all
    Grade.with_deleted.delete_all
    add_reference :grades, :account, foreign_key: true, type: :uuid, null: false
  end
end
