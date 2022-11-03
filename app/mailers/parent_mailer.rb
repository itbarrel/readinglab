# frozen_string_literal: true

class ParentMailer < ApplicationMailer
  def klass_mailer(parent)
    @parent = parent
    mail(to: @parent.father_email, subject: 'Test Email for Letter Opener')
  end
end
