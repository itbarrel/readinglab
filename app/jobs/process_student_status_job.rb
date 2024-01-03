# frozen_string_literal: true

require 'sidekiq-scheduler'

class ProcessStudentStatusJob
  include Sidekiq::Worker

  def perform
    students_without_classes = Student.includes(:student_classes)
                                      .where(student_classes: { id: nil })
                                      .where(status: :active)
    students_without_classes.find_each(batch_size: 50) do |student|
      student.update(status: :wait_listed)
    end
    students_with_classes = Student.includes(:student_classes)
                                   .where.not(student_classes: { id: nil })
                                   .where(status: :wait_listed)
    students_with_classes.find_each(batch_size: 50) do |student|
      student.update(status: :active)
    end
  end
end
