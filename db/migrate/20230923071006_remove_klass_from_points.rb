class RemoveKlassFromPoints < ActiveRecord::Migration[7.0]
  def change
    remove_reference :trajectory_details, :klass, foreign_key: true, type: :uuid
  end
end
