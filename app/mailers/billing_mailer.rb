# frozen_string_literal: true

class BillingMailer < ApplicationMailer
  def mailer(student, parent, reason)
    @student = student
    @reason = reason

    mail(to: parent.father_email, subject: 'Fee Submission Reminder')
  end
end
