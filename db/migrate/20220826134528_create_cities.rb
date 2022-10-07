# frozen_string_literal: true

class CreateCities < ActiveRecord::Migration[7.0]
  def change
    create_table :cities, id: :uuid do |t|
      t.string :name
      
      t.timestamps
      t.datetime :deleted_at
    end
    add_index :cities, [:name, :deleted_at], unique: true, name: 'cities_name'

  end
end
