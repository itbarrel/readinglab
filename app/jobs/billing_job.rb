# frozen_string_literal: true

require 'sidekiq-scheduler'

class BillingJob
  include Sidekiq::Worker

  def perform
    students = Student.all
    students.each do |student|
      next_billing_date = student.next_billing_date
      if next_billing_date.present?
        days_until_next_billing = (next_billing_date - Time.today).to_i
        BillingMailer.mailer(student).deliver_now if days_until_next_billing == 7 || 1.day
      end
    end
  end
end
