# frozen_string_literal: true

require 'csv'
class ApplicationRecord < ActiveRecord::Base
  has_paper_trail ignore: %i[id created_at updated_at obsoleted_at deleted_at]
  primary_abstract_class
  include Randomizer

  acts_as_paranoid

  VIEW_ADDED_ATTRIBUTES = %i[].freeze
  VIEW_REJECTED_ATTRIBUTES = %i[id created_at updated_at deleted_at].freeze
  EXPORT_REJECTED_ATTRIBUTES = %i[id deleted_at].freeze
  CHANGED_ATTRIBUTES = {}.freeze

  def viewable_attribs
    added_hash = self.class::VIEW_ADDED_ATTRIBUTES.index_with { |key| send(key) }.symbolize_keys
    serializable_hash
      .reject { |key, _| self.class::VIEW_REJECTED_ATTRIBUTES.include?(key.to_sym) }
      .merge(added_hash)
      .symbolize_keys
  end

  def self.to_csv(_options = {})
    attributes = Hash[all.model.column_names.map { |key, _value| [key, human_attribute_name(key)] }].symbolize_keys
    attributes.except!(*EXPORT_REJECTED_ATTRIBUTES).merge!(CHANGED_ATTRIBUTES)

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
