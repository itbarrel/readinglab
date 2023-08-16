# frozen_string_literal: true

require 'sidekiq-scheduler'

class AttendanceReminderJob
  include Sidekiq::Worker

  def perform
    yesterday = Date.yesterday
    previous_meetings = Meeting.where('Date(starts_at) = ?', yesterday)
    not_attendance_meetings = previous_meetings.left_outer_joins(:student_meetings).where(student_meetings: { meeting_id: nil })

    not_attendance_meetings.each do |meeting|
      users = meeting.account.users.where(role: :admin)
      users ||= meeting.account.users.where(role: :super_visor) if users.empty?

      users.each do |x|
        notification = x.notifications.find_or_initialize_by(record: meeting, purpose: :missing_attendance)
        notification.save unless notification.persisted?
      end
    end

    attendance_meetings = previous_meetings.joins(:student_meetings)

    attendance_meetings.each do |meeting|
      students_with_attendance = meeting.student_meetings.map(&:student_id)
      all_students = meeting.klass.student_classes.map(&:student_id)

      users = meeting.account.users.where(role: :admin)
      users ||= meeting.account.users.where(role: :super_visor) if users.empty?

      Student.where(id: all_students - students_with_attendance).each do |stu|
        users.each do |x|
          notification = x.notifications.find_or_initialize_by(record: stu, purpose: :missing_attendance)
          notification.save unless notification.persisted?
        end
      end
    end
  end
end
