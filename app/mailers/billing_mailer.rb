# frozen_string_literal: true

class BillingMailer < ApplicationMailer
  def mailer(email)
    mail(to: email, subject: 'fee_submission_reminder')
  end
end
