# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  include Randomizer

  acts_as_paranoid

  connects_to database: { writing: :primary }

  def self.default_seeds
    []
  end
end
