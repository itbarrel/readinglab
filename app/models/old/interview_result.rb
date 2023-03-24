# frozen_string_literal: true

class Old::InterviewResult < Old::ApplicationRecord
  belongs_to :account, class_name: 'Old::Account'
  belongs_to :student, class_name: 'Old::Student'
  belongs_to :interview, class_name: 'Old::Interview'
  belongs_to :form, class_name: 'Old::Form'
  scope :active, -> { where(active: true) }
  acts_as_paranoid
end
