# frozen_string_literal: true

class Old::PaidStudentSession < Old::ApplicationRecord
  belongs_to :student, class_name: 'Old::Student'
  belongs_to :receipt, class_name: 'Old::Receipt'
  belongs_to :meeting, class_name: 'Old::Meeting'
end
