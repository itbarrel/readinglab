# frozen_string_literal: true

# == Schema Information
#
# Table name: receipts
#
#  id              :uuid             not null, primary key
#  amount          :decimal(, )
#  deleted_at      :string
#  detail          :text
#  discount        :integer
#  discount_reason :string
#  leave_count     :integer
#  sessions_count  :integer          default(8)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  account_id      :uuid             not null
#  receipt_type_id :uuid             not null
#  student_id      :uuid             not null
#
# Indexes
#
#  index_receipts_on_account_id       (account_id)
#  index_receipts_on_receipt_type_id  (receipt_type_id)
#  index_receipts_on_student_id       (student_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (receipt_type_id => receipt_types.id)
#  fk_rails_...  (student_id => students.id)
#
class Receipt < ApplicationRecord
  belongs_to :account
  belongs_to :student
  belongs_to :receipt_type
  has_many :payments, dependent: nil

  attr_accessor :skip_callbacks

  validates :amount, :sessions_count, presence: true
  before_validation :validate_payable_meetings, on: :create

  after_create :create_payments, unless: :skip_callbacks

  def create_payments
    student.payable_meetings.take(sessions_count).each do |meeting|
      payments.create(student:, meeting:)
    end
  end

  private

  def validate_payable_meetings
    return true if student.payable_meetings.any?

    errors.add(:base, 'Student has no sessions to pay for.')
    false
  end
end
