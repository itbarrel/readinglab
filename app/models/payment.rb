# frozen_string_literal: true

# == Schema Information
#
# Table name: payments
#
#  id         :uuid             not null, primary key
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  meeting_id :uuid             not null
#  receipt_id :uuid
#  student_id :uuid             not null
#
# Indexes
#
#  index_payments_on_meeting_id  (meeting_id)
#  index_payments_on_receipt_id  (receipt_id)
#  index_payments_on_student_id  (student_id)
#
# Foreign Keys
#
#  fk_rails_...  (meeting_id => meetings.id)
#  fk_rails_...  (receipt_id => receipts.id)
#  fk_rails_...  (student_id => students.id)
#
class Payment < ApplicationRecord
  belongs_to :student
  belongs_to :receipt, optional: true

  has_many :meetings, through: :payment_meetings
end
