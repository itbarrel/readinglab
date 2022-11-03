# frozen_string_literal: true

# == Schema Information
#
# Table name: student_meetings
#
#  id         :uuid             not null, primary key
#  attendance :integer
#  deleted_at :datetime
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :uuid             not null
#  meeting_id :uuid             not null
#  student_id :uuid             not null
#
# Indexes
#
#  index_student_meetings_on_account_id  (account_id)
#  index_student_meetings_on_meeting_id  (meeting_id)
#  index_student_meetings_on_student_id  (student_id)
#  student_meeting_id                    (account_id,meeting_id,student_id,deleted_at) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (meeting_id => meetings.id)
#  fk_rails_...  (student_id => students.id)
#
require 'test_helper'

class StudentMeetingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
