# frozen_string_literal: true

class Old::StudentClass < Old::ApplicationRecord
  belongs_to :account, class_name: 'Old::Account'
  belongs_to :student, class_name: 'Old::Student'
  belongs_to :r_class, class_name: 'Old::RClass'
  acts_as_paranoid
  scope :active, -> { where(active: true) }
  # Student.where(id: StudentClass.active.map(&:student_id))
end
