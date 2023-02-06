# frozen_string_literal: true

class StaffMailer < ApplicationMailer
  def mailer(record, email_data)
    @record = record
    @email_data = email_data
    mail(to: @record.email, subject: email_data[:title])
  end
end
