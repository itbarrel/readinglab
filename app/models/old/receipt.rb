# frozen_string_literal: true

class Old::Receipt < Old::ApplicationRecord
  belongs_to :account, class_name: 'Old::Account'
  belongs_to :student, class_name: 'Old::Student'
  belongs_to :receipt_type, class_name: 'Old::ReceiptType'
  has_many :paid_student_sessions, dependent: :destroy, class_name: 'Old::PaidStudentSession'

  acts_as_paranoid
  scope :active, -> { where(active: true) }
end
