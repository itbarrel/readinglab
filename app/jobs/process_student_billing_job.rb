# frozen_string_literal: true

require 'sidekiq-scheduler'

class ProcessStudentBillingJob
  include Sidekiq::Worker

  def perform(student_id)
    student = Student.find(student_id)

    current_time = Time.zone.now
    paid_sessions = student.receipts.where('created_at < ?', current_time.end_of_day).sum(:sessions_count)
    consumed_sessions = student.billable_meetings.where('starts_at < ?', current_time.end_of_day).count
    net_credit = student.credit_sessions.to_i + paid_sessions - consumed_sessions
    student.update(credit_sessions: net_credit, last_session_processed: current_time)
  end
end
