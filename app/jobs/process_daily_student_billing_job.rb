# frozen_string_literal: true

require 'sidekiq-scheduler'

class ProcessDailyStudentBillingJob
  include Sidekiq::Worker

  def perform
    today = Time.zone.now.beginning_of_day..Time.zone.now.end_of_day
    today_meetings = Meeting.where(starts_at: today)
    mapp = {}
    today_meetings.each do |meeting|
      meeting.students.each do |student|
        mapp[student.id] ||= 0
        sav = student.approved_vacations.where('start_date <= ? AND end_date >= ?', meeting.starts_at, meeting.starts_at)
        mapp[student.id] += 1 unless sav.any?
      end
    end

    mapp.each do |student_id, meeting_count|
      student = Student.find(student_id)
      cs = student.credit_sessions - meeting_count
      student.update(credit_sessions: cs, last_session_processed: Time.zone.now)
    end
  end
end
