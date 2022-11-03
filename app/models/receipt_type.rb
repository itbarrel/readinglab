# frozen_string_literal: true

# == Schema Information
#
# Table name: receipt_types
#
#  id         :uuid             not null, primary key
#  deleted_at :datetime
#  name       :string
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :uuid             not null
#
# Indexes
#
#  index_receipt_types_on_account_id  (account_id)
#  receipt_types_name                 (account_id,name,deleted_at) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class ReceiptType < ApplicationRecord
  belongs_to :account
  enum :status, %i[tution_fee addmission_fee sports_fee]

  validates :name, :status, presence: true, uniqueness: { scope: %i[account_id name deleted_at] }
end
