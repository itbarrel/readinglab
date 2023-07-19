# frozen_string_literal: true

require 'sidekiq-scheduler'

class BillingJob
  include Sidekiq::Worker
  include ApplicationHelper

  def perform
    compare_date = DateTime.new
    students = Student.all
    students.each do |student|
      next_billing_date = student.next_billing_date
      next if next_billing_date.blank?

      days_until_next_billing = (next_billing_date - compare_date).to_i
      days_until_next_billing_string = seconds_to_days(days_until_next_billing)
      reason = determine_reason(days_until_next_billing_string)
      parent = student.parent

      BillingMailer.mailer(student, parent, reason).deliver_now if student.account.notify_emails? && [7,
                                                                                                      1].include?(days_until_next_billing_string)
    end
  end

  private

  def determine_reason(days_until_next_billing)
    case days_until_next_billing
    when 7
      '7 days left for fee submission'
    when 1
      '1 day left for fee submission'
    else
      'Fee submission overdue'
    end
  end
end
