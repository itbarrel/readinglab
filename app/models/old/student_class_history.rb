# frozen_string_literal: true

class Old::StudentClassHistory < Old::ApplicationRecord
  belongs_to :account, class_name: 'Old::Account'
  belongs_to :student, class_name: 'Old::Student'
  belongs_to :r_class, class_name: 'Old::Rclass'
  belongs_to :user, class_name: 'Old::User'
  acts_as_paranoid
  scope :active, -> { where(active: true) }
end
