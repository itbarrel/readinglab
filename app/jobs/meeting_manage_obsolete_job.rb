# frozen_string_literal: true

require 'sidekiq-scheduler'

class MeetingManageObsoleteJob
  include Sidekiq::Worker

  def perform(meeting_id)
    meeting = Meeting.find(meeting_id)
    obsolete_time = meeting.obsolete? ? Time.zone.now : nil
    student_meetings_to_handle = meeting.obsolete? ? meeting.student_meetings.working : meeting.student_meetings.obsolete
    form_details_to_handle = meeting.obsolete? ? meeting.form_details.working : meeting.form_details.obsolete

    meeting.update(obsoleted_at: obsolete_time)
    student_meetings_to_handle.each do |x|
      x.update(obsolete: meeting.obsolete?)
    end
    form_details_to_handle.each do |x|
      x.update(obsolete: meeting.obsolete?)
    end
  end
end
