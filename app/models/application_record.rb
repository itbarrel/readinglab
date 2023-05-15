# frozen_string_literal: true

require 'csv'
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  include Randomizer

  acts_as_paranoid

  connects_to database: { writing: :primary }

  REJECTED_ATTRIBUTES = %i[id deleted_at].freeze
  CHANGED_ATTRIBUTES = {}.freeze

  def self.default_seeds
    []
  end

  def self.to_csv
    attributes = Hash[all.model.column_names.map { |key, _value| [key, human_attribute_name(key)] }].symbolize_keys
    attributes.except!(*REJECTED_ATTRIBUTES).merge!(CHANGED_ATTRIBUTES)

    CSV.generate(headers: true) do |csv|
      csv << attributes.values

      all.find_each do |record|
        csv << attributes.keys.map do |key|
          record[key]
        end
      end
    end
  end
end
