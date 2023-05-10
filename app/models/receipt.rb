# frozen_string_literal: true

# == Schema Information
#
# Table name: receipts
#
#  id              :uuid             not null, primary key
#  amount          :decimal(, )
#  datetime        :string
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

  validates :amount, :sessions_count, presence: true
end
