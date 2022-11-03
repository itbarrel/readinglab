# frozen_string_literal: true

class StudentMailer < ApplicationMailer
  def mashal(parent)
    @parent = parent
    mail(to: @parent.father_email)
  end
end
