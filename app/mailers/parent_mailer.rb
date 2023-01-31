# frozen_string_literal: true

class ParentMailer < ApplicationMailer
  def klass_mailer(parent, email_data)
    @email_data = email_data
    @parent = parent.map(&:father_email)
    mail(to: @parent, subject: 'Test Email for Letter Opener')
  end
end
