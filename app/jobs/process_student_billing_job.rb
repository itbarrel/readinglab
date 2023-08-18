# frozen_string_literal: true

require 'sidekiq-scheduler'

class ProcessStudentBillingJob
  include Sidekiq::Worker

  def perform(student_id)
    duration = 1.month

    student = Student.find(student_id)

    if student.last_session_processed.blank?
      student.update!(last_session_processed: [
        student.student_classes.order(created_at: :asc)&.first&.created_at,
        student.receipts.order(created_at: :asc)&.first&.created_at,
        student.student_meetings.order(created_at: :asc)&.first&.created_at
      ].compact.min)
    end

    duration_clause = (student.last_session_processed..(student.last_session_processed + duration))

    # meeting_purchased = student.meeting_purchased

    student.student_meetings.where(created_at: duration_clause).count

    # return if student.student_meetings.empty? && student.student_classes.empty?

    # if student.session_processed_at.blank?
    #   initial_attendance = student.student_meetings.first&.created_at
    #   initial_admission = student.student_classes.order(created_at: :asc).first&.created_at
    #   new_session_processed_at = [initial_attendance, initial_admission].compact.min
    #   student.update!(session_processed_at: new_session_processed_at)
    # end

    # student.student_meetings.where(created_at: student.session_processed_at..(student.session_processed_at + duration)).map(&:meeting_id)
    # student.meetings.where(starts_at: student.session_processed_at..(student.session_processed_at + duration)).ids

    # sm_ids - m_ids # if left class and attendance is there for that meeting
    # m_ids - sm_ids # if no attendance submitted

    # Rails.logger.debug 'azeem here', student.id, '>>>>>>>left>>>>>>>>>', sm_ids - m_ids, '>>>>>>>attendance>>>>>', m_ids - sm_ids
    # Rails.logger.debug 'm count ', m_ids.count, '>>>>>>>sm count>>>>>>>>>', sm_ids.count
    # byebug
  end
end
