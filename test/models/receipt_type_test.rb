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
require 'test_helper'

class ReceiptTypeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
