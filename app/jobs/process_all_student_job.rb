# frozen_string_literal: true

require 'sidekiq-scheduler'

class ProcessAllStudentJob
  include Sidekiq::Worker

  def perform
    students = Student.active.where('last_session_processed < ?', 1.month.ago) + Student.active.where(last_session_processed: nil)
    students.each do |student|
      ProcessStudentBillingJob.perform_async(student.id)
    end
  end
end
