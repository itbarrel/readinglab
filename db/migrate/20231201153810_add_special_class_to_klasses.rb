class AddSpecialClassToKlasses < ActiveRecord::Migration[7.0]
  def change
    add_column :klasses, :special_class, :boolean ,default: false
  end
end