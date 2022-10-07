# frozen_string_literal: true

# == Schema Information
#
# Table name: rooms
#
#  id         :uuid             not null, primary key
#  capacity   :integer
#  color      :string
#  deleted_at :datetime
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :uuid             not null
#
# Indexes
#
#  index_rooms_on_account_id  (account_id)
#  rooms_name                 (account_id,name,deleted_at) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
require 'test_helper'

class RoomTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
