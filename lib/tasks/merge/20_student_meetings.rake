# frozen_string_literal: true

namespace :merge do
  desc 'Merges student_meetings to new tables'
  task student_meetings: :environment do
    students = {}

    Student.all.each do |x|
      students[x.id] = true
    end

    meetings = {}

    Meeting.all.each do |x|
      meetings[x.id] = true
    end

    attendance_mapping = {
      'Present': 'present',
      'Absent': 'absent',
      'Leave': 'leave'
    }

    Old::StudentMeeting.find_each(batch_size: 200) do |old_student_meeting|
      next unless students[old_student_meeting.student_id] && meetings[old_student_meeting.meeting_id]

      attendance = :nothing
      StudentMeeting.find_or_create_by!(
        account_id: old_student_meeting.account_id,
        student_id: old_student_meeting.student_id,
        meeting_id: old_student_meeting.meeting_id
      ) do |student_meeting|
        student_meeting.id = old_student_meeting.id
        attendance = attendance_mapping[old_student_meeting.attended.to_sym] unless old_student_meeting.attended.nil?
        student_meeting.attendance = attendance
        student_meeting.created_at = old_student_meeting.created_at
        student_meeting.updated_at = old_student_meeting.updated_at
        student_meeting.deleted_at = old_student_meeting.active ? old_student_meeting.deleted_at : old_student_meeting.updated_at
      end
    end
    puts 'Successfully Merged Student Meeting.'
  end
end
