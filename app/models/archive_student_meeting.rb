# frozen_string_literal: true

# == Schema Information
#
# Table name: archive_student_meetings
#
#  id                         :uuid             not null, primary key
#  attendance                 :integer
#  deleted_at                 :datetime
#  student_meeting_created_at :datetime
#  student_meeting_deleted_at :datetime
#  student_meeting_updated_at :datetime
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  account_id                 :uuid             not null
#  archive_meeting_id         :uuid             not null
#  student_id                 :uuid             not null
#
# Indexes
#
#  archive_student_meeting_id                            (account_id,archive_meeting_id,student_id,deleted_at) UNIQUE
#  index_archive_student_meetings_on_account_id          (account_id)
#  index_archive_student_meetings_on_archive_meeting_id  (archive_meeting_id)
#  index_archive_student_meetings_on_student_id          (student_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (archive_meeting_id => archive_meetings.id)
#  fk_rails_...  (student_id => students.id)
#
class ArchiveStudentMeeting < ApplicationRecord
  belongs_to :account
  belongs_to :archive_meeting
  belongs_to :student
end
