class RemoveDatetimeFromReceipts < ActiveRecord::Migration[7.0]
  def change
    remove_column :receipts, :datetime, :string
  end
end
