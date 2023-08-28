# frozen_string_literal: true

require 'sidekiq-scheduler'

class ProcessStudentBillingJob
  include Sidekiq::Worker

  def perform(student_id)
    student = Student.find(student_id)

    if student.last_session_processed.blank?
      student.update!(last_session_processed: [
        student.student_classes.order(created_at: :asc)&.first&.created_at,
        student.receipts.order(created_at: :asc)&.first&.created_at,
        student.student_meetings.order(created_at: :asc)&.first&.created_at
      ].compact.min - 2.months)
    end

    return if student.last_session_processed.blank?

    duration_clause = (student.last_session_processed.beginning_of_month..(student.last_session_processed.end_of_month))

    paid_sessions = student.receipts.where(created_at: duration_clause).sum(:sessions_count)
    consumed_sessions = student.student_meetings.where(created_at: duration_clause).where(attendance: %i[present absent]).count
    net_credit = student.credit_sessions.to_i + paid_sessions - consumed_sessions

    student.update(credit_sessions: net_credit, last_session_processed: student.last_session_processed.end_of_month + 10.minutes)

    ProcessStudentBillingJob.perform_in(2.seconds, student.id) if student.last_session_processed < 1.month.ago
  end
end
