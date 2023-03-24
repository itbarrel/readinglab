# frozen_string_literal: true

class Old::Room < Old::ApplicationRecord
  belongs_to :account, class_name: 'Old::Account'
  has_many :r_classes, class_name: 'Old::RClass'
  has_many :meetings, through: :r_classes, class_name: 'Old::Meeting'
  has_many :assessments, class_name: 'Old::Assessment'
  acts_as_paranoid
  scope :active, -> { where(active: true) }
end
