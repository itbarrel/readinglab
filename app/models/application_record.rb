# frozen_string_literal: true

require 'csv'
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  include Randomizer

  acts_as_paranoid

  # @@exportable_attributes = {}

  def self.to_csv
    @@exportable_attributes.each do |key, _value|
      disply_attributes = @@exportable_attributes.values
      CSV.generate(headers: true) do |csv|
        csv << disply_attributes

        all.find_each do |record|
          row_data = [
            record[key]
          ]
          csv << row_data
        end
      end
    end
  end
end
