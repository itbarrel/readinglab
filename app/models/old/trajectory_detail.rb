# frozen_string_literal: true

class Old::TrajectoryDetail < Old::ApplicationRecord
  belongs_to :account, class_name: 'Old::Account'
  # belongs_to :r_class
  belongs_to :student, class_name: 'Old::Student'
  belongs_to :book, class_name: 'Old::Book'
  acts_as_paranoid
  scope :active, -> { where(active: true) }
end
