class RemoveKlassFromBooks < ActiveRecord::Migration[7.0]
  def change
    remove_reference :books, :klass, foreign_key: true, type: :uuid
  end
end
