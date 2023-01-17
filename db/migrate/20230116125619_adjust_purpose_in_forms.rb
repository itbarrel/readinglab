class AdjustPurposeInForms < ActiveRecord::Migration[7.0]
  def change
    remove_column :forms, :lessonable
    remove_column :forms, :attendancable
    add_column :forms, :purpose, :integer
  end
end
