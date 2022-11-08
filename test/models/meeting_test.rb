# frozen_string_literal: true

# == Schema Information
#
# Table name: meetings
#
#  id         :uuid             not null, primary key
#  cancel     :boolean
#  deleted_at :datetime
#  ends_at    :datetime
#  hold       :boolean
#  starts_at  :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :uuid             not null
#  klass_id   :uuid             not null
#
# Indexes
#
#  index_meetings_on_account_id  (account_id)
#  index_meetings_on_klass_id    (klass_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (klass_id => klasses.id)
#
require 'test_helper'

class MeetingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
