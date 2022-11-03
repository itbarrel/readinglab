# frozen_string_literal: true

class VacationMailer < ApplicationMailer
  def holiday(parent)
    @parent = parent
    mail(to: @parent.father_email, subject: 'today is holiday')
  end
end
