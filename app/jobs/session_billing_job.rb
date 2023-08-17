# frozen_string_literal: true

require 'sidekiq-scheduler'

class SessionBillingJob
  include Sidekiq::Worker

  def perform
    duration = 1.month

    Student.all.each do |stu|
      next if stu.student_meetings.empty? && stu.student_classes.empty?

      if stu.session_processed_at.blank?
        initial_attendance = stu.student_meetings.first&.created_at
        initial_admission = stu.student_classes.order(created_at: :asc).first&.created_at
        new_session_processed_at = [initial_attendance, initial_admission].compact.min
        stu.update!(session_processed_at: new_session_processed_at)
      end

      stu.student_meetings.where(created_at: stu.session_processed_at..(stu.session_processed_at + duration)).map(&:meeting_id)
      stu.meetings.where(starts_at: stu.session_processed_at..(stu.session_processed_at + duration)).ids

      # sm_ids - m_ids # if left class and attendance is there for that meeting
      # m_ids - sm_ids # if no attendance submitted

      # Rails.logger.debug 'azeem here', stu.id, '>>>>>>>left>>>>>>>>>', sm_ids - m_ids, '>>>>>>>attendance>>>>>', m_ids - sm_ids
      # Rails.logger.debug 'm count ', m_ids.count, '>>>>>>>sm count>>>>>>>>>', sm_ids.count
      # byebug
    end
  end
end
