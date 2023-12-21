# frozen_string_literal: true

require 'sidekiq-scheduler'

class ProcessAllStudentJob
  include Sidekiq::Worker

  def perform
    Student.active.find_each(batch_size: 50) do |student|
      student.update(credit_sessions: 0, last_session_processed: nil)
    end
    Student.active.each do |student|
      ProcessStudentBillingJob.perform_async(student.id)
    end
  end
end
