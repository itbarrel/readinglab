# frozen_string_literal: true

# == Schema Information
#
# Table name: student_meetings
#
#  id           :uuid             not null, primary key
#  attendance   :integer
#  deleted_at   :datetime
#  obsolete     :boolean          default(FALSE)
#  obsoleted_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  account_id   :uuid             not null
#  meeting_id   :uuid             not null
#  student_id   :uuid             not null
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
class StudentMeeting < ApplicationRecord
  belongs_to :account
  belongs_to :meeting
  belongs_to :student
  enum :attendance, %i[absent present leave]

  scope :obsolete, -> { where obsolete: true }
  scope :working, -> { where obsolete: false }

  validates :attendance, presence: true

  after_save :handle_obsolete, if: :saved_change_to_obsolete?

  private

  def handle_obsolete
    obsolete_time = obsolete? ? Time.zone.now : nil

    update(obsoleted_at: obsolete_time)
  end
end
