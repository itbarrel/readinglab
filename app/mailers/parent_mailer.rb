# frozen_string_literal: true

class ParentMailer < ApplicationMailer
  def mailer(record, email_data)
    @record = record
    @email_data = email_data
    mail(to: @record.parent.father_email, subject: email_data[:title])
  end
end
