class AddColumnsInUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :active, :boolean, default: true
    add_column :users, :status, :integer
  end
end
