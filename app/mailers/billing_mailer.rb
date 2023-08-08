# frozen_string_literal: true

class BillingMailer < ApplicationMailer
  def mailer(student, parent, reason)
    @student = student
    @reason = reason
    @email_text = "This is a reminder regarding the fee submission for #{student.name} "

    mail(to: parent.father_email, subject: 'Fee Submission Reminder')
  end
end
