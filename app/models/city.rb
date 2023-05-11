# frozen_string_literal: true

# == Schema Information
#
# Table name: cities
#
#  id         :uuid             not null, primary key
#  deleted_at :datetime
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  cities_name  (name,deleted_at) UNIQUE
#
class City < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: %i[name deleted_at] }

  def self.default_seeds
    %w[Karachi]
  end
end
