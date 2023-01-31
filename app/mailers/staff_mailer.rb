# frozen_string_literal: true

class StaffMailer < ApplicationMailer
  def staff_mailer(staff, email_data)
    @email_data = email_data
    @staff = staff.map(&:email)
    mail(to: @staff, subject: 'Test Email for Letter Opener', body: @email_data)
  end
end
