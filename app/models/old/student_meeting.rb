# frozen_string_literal: true

class Old::StudentMeeting < Old::ApplicationRecord
  belongs_to :account, class_name: 'Old::Account'
  belongs_to :meeting, class_name: 'Old::Meeting'
  belongs_to :student, class_name: 'Old::Student'
  belongs_to :form, class_name: 'Old::Form'
  scope :valid, -> { where.not(attended: nil) }
  scope :active, -> { where(active: true, deleted_at: nil) }
  acts_as_paranoid
end
