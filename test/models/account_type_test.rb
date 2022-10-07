# frozen_string_literal: true

# == Schema Information
#
# Table name: account_types
#
#  id         :uuid             not null, primary key
#  deleted_at :datetime
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  account_types_name  (name,deleted_at) UNIQUE
#
require 'test_helper'

class AccountTypeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
