# frozen_string_literal: true

class Old::Account < Old::ApplicationRecord
  has_many :students, class_name: 'Old::Student'
  has_many :users, class_name: 'Old::User'
  has_many :student_class_histories, class_name: 'Old::StudentClassHistory'

  has_and_belongs_to_many :account_types, class_name: 'Old::AccountType'

  # has_many :class_templates
  scope :active, -> { where(active: true) }
end
