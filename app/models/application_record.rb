# frozen_string_literal: true

require 'csv'
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  include Randomizer

  acts_as_paranoid

  @exportable_attributes = {}

  def self.to_csv
    CSV.generate(headers: true) do |csv|
      csv << @exportable_attributes.values

      all.find_each do |record|
        csv << @exportable_attributes.keys.map do |key|
          record[key]
        end
      end
    end
  end
end
